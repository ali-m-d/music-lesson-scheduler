class HomeController < ApplicationController
  def index
    @destination = 'landing'
    if params.has_key?("destination")
      @destination = params[:destination]
    end
  end
  
  def landing
    @destination = 'landing'
    respond_to do |format|
      format.html { redirect_to root_path(destination: 'landing') }
      format.js
    end
  end

  def about
    @destination = 'about'
    respond_to do |format|
      format.html { redirect_to root_path(destination: 'about') }
      format.js
    end
  end
  
  def contact
    @destination = 'contact'
    respond_to do |format|
      format.html { redirect_to root_path(destination: 'contact') }
      format.js
    end
  end

end
