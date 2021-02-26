require './config/environment'

class ApplicationController < Sinatra::Base




  configure do
    set :views, 'app/views'
    enable :sessions
    set :session_secret, "password_security"
    register Sinatra::Flash

  end

  # add_flash_types :info, :success, :warning, :danger 


  get "/" do
    erb :welcome
  end

  helpers do # makes these methods availble to controller and views

    #return the logged in user
    def current_user 
      @current_user ||= Skater.find_by_id(session[:skater_id]) #memoization
    end 


    #check if user is logged in
    def logged_in? 
      !!session[:skater_id]
    end 

  end 

end
