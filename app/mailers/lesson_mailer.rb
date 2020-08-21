class LessonMailer < ApplicationMailer
    helper :application
    
    default from: "mailer@rebecca-railton.com"
    
    def lesson_scheduled
       @lesson = params[:lesson]
       @user = params[:user]
       @charge = (@lesson.duration * 41) / 100.0
       # attachments.inline["piano.svg"] = File.read("#{Rails.root}/app/assets/images/piano.svg")
       mail(to: @user.email, subject: "Lesson Booking Confirmation")
    end
end
