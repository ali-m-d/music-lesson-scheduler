class MessagesController < ApplicationController
    
    def new
        @message = Message.new(message_params)
    end
    
    def create
        @message = Message.create(content: params[:message][:content], email: params[:message][:email])
        
        respond_to do |format|
            if @message.save
                format.html { redirect_to root_path, notice: "Message sent successfully" }
            else
                format.html { redirect_to root_path, notice: "Comment could not be saved." }
            end
        end
    end
    
    private
    
    def comment_params
       params.require(:message).permit(:content, :email) 
    end
    
end