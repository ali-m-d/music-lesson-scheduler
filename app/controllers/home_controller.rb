class HomeController < ApplicationController
  def index
    
  end
  
  def landing
    @destination = 'landing'
    respond_to do |format|
      format.html { redirect_to home_path(dest: "landing") }
      format.js
    end
  end

  def about
    @destination = 'about'
    respond_to do |format|
      format.html { redirect_to home_path(dest: "about") }
      format.js
    end
  end
  
  def contact
    @destination = 'contact'
    respond_to do |format|
      format.html { redirect_to home_path(dest: "contact") }
      format.js
    end
  end

end
