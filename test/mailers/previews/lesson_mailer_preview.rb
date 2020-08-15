# Preview all emails at http://localhost:3000/rails/mailers/lesson_mailer
class LessonMailerPreview < ActionMailer::Preview
    def lesson_scheduled
        LessonMailer.with(lesson: Lesson.first, user: User.first).lesson_scheduled
    end
end
