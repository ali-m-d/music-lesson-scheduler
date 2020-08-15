class LessonsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_lesson, only: [:show, :edit, :update, :destroy]

  # GET /lessons
  # GET /lessons.json
  def index
    if current_user.admin?
      @lessons = Lesson.all
    else      
      @lessons = current_user.lessons.where(user_id: current_user)
    end
  end

  # GET /lessons/1
  # GET /lessons/1.json
  def show
    @comment = Comment.new
  end

  # GET /lessons/new
  def new
    @lesson = Lesson.new
  end

  # GET /lessons/1/edit
  def edit
  end

  # POST /lessons
  # POST /lessons.json
  def create
    @lesson = Lesson.new(user_id: current_user.id)
    @lesson.update("start_time(1i)": params["lesson"]["start_time(1i)"], "start_time(2i)": params["lesson"]["start_time(2i)"], "start_time(3i)": params["lesson"]["start_time(3i)"], "start_time(4i)": params["lesson"]["start_time(4i)"], "start_time(5i)": params["lesson"]["start_time(5i)"])
    @lesson.update("duration": params["lesson"]["duration"])
    
    start_time = Time.new(params["lesson"]["start_time(1i)"], params["lesson"]["start_time(2i)"], params["lesson"]["start_time(3i)"], params["lesson"]["start_time(4i)"], params["lesson"]["start_time(5i)"])
    end_time = start_time + params["lesson"]["duration"].to_i * 60
  
    @lesson.update("end_time(1i)": end_time.year.to_s, "end_time(2i)": end_time.month.to_s, "end_time(3i)": end_time.day.to_s, "end_time(4i)": end_time.hour.to_s, "end_time(5i)": end_time.min.to_s)
    
    token = params[:stripeToken]
    card_brand = params[:user][:card_brand]
    card_exp_month = params[:user][:card_exp_month]
    card_exp_year = params[:user][:card_exp_month]
    card_last4 = params[:user][:card_last4]
    
    charge = Stripe::Charge.create(
      amount: 2500,
      currency: "gbp",
      description: "Music Lesson",
      source: token
    )
    
    current_user.stripe_id = charge.id
    current_user.card_brand = card_brand
    current_user.card_exp_month = card_exp_month
    current_user.card_exp_year = card_exp_year
    current_user.card_last4 = card_last4
    current_user.save

    respond_to do |format|
      if @lesson.save
        format.html { redirect_to @lesson, notice: 'Lesson scheduled!' }
        format.json { render :show, status: :created, location: @lesson }
        LessonMailer.with(lesson: @lesson, user: current_user).lesson_scheduled.deliver_now
      else
        format.html { render :new }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
    
    rescue Stripe::CardError => e
      flash.alert = e.message
      render action: :new
    
  end

  # PATCH/PUT /lessons/1
  # PATCH/PUT /lessons/1.json
  def update
    respond_to do |format|
      if @lesson.update(lesson_params)
        format.html { redirect_to @lesson, notice: 'Lesson was successfully updated.' }
        format.json { render :show, status: :ok, location: @lesson }
      else
        format.html { render :edit }
        format.json { render json: @lesson.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lessons/1
  # DELETE /lessons/1.json
  def destroy
    @lesson.destroy
    respond_to do |format|
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully cancelled.' }
      format.json { head :no_content }
    end
  end

  private
    
    def must_be_admin
        unless current_user.admin?      
            redirect_to lessons_path, alert: "You don't have access to this page" 
        end
    end
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:name, :start_time, :duration, :end_time, :user_id)
    end
end
