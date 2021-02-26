require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    register Sinatra::Flash

  end

  get "/" do
    erb :welcome
  end

  helpers do # makes these methods availble to controller and views

    def current_user 
      @current_user ||= Skater.find_by_id(session[:skater_id])
    end 

    def logged_in? 
      !!session[:skater_id]
    end 

    # return the logged in user
  #  def current_user # return logged in user 
  #   @current_user ||= Skater.find_by_id(session[:skater_id]) #memoization
  #  end 

  #   # check if a user logged in
  #   def logged_in?
  #     !!session[:skater_id]
  #   end 

  end 

end
