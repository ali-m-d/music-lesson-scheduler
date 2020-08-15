module ApplicationHelper
    def readable_date(time)
       time.strftime("%b %d, %I:%M%P") 
    end
    
    def readable_day(time)
       time.strftime("%b %d") 
    end
    
    def readable_time(time)
       time.strftime("%I:%M%P") 
    end
    
    def author_of(record)
        user_signed_in? && current_user.id == record.user_id 
    end
    
    def admin?
        user_signed_in? && current_user.admin? 
    end
    
    def remote?
       if controller_name == 'lessons' || controller_name == 'users'
           return false
       else
           return true
       end
    end
end
