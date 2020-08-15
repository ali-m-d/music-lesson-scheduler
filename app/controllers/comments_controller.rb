class CommentsController < ApplicationController
    before_action :authenticate_user!
    before_action :set_comment, only: [:edit, :update, :show, :destroy]
    before_action :set_lesson
    
    def new
       @comment = Comment.new 
    end
    
    def create
        @comment = @lesson.comments.create(reply: params[:comment][:reply], user_id: current_user.id) 
       
        respond_to do |format|
            if @comment.save
                format.html { redirect_to lesson_path(@lesson) } 
                format.js # render create.js.erb
            else
                format.html { redirect_to lesson_path(@lesson), notice: "Comment could not be saved." }
            end
        end
    end
    
    def destroy
        @comment = @lesson.comments.find(params[:id])
        @comment.destroy
        redirect_to lesson_path(@lesson)
    end
    
    private
    
    def set_lesson
        @lesson = Lesson.find(params[:lesson_id])
    end
    
    def set_comment
        @comment = Comment.find(params[:id]) 
    end
    
    def comment_params
       params.require(:comment, :lesson).permit(:reply, :user_name) 
    end
end
