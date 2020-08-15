class LessonMailer < ApplicationMailer
    helper :application
    
    default from: "noreply@rebeccarailton.com"
    
    def lesson_scheduled
       @lesson = params[:lesson]
       @user = params[:user]
       attachments.inline["piano.svg"] = File.read("#{Rails.root}/app/assets/images/piano.svg")
       mail(to: @user.email, subject: "Lesson Booking Confirmation")
    end
end
