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
    @lesson = Lesson.new(lesson_params)
    @lesson.user_id = current_user.id
    
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
      format.html { redirect_to lessons_url, notice: 'Lesson was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def lesson_params
      params.require(:lesson).permit(:name, :start_time, :end_time, :user_id)
    end
end
