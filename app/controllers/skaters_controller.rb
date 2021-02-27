class SkatersController < ApplicationController


    get '/signup' do # render signup form
        erb :'skaters/signup'
    end 

    post '/signup' do
        skater = Skater.new(params)
        # validate our author object
        # if author.username != ""
        if skater.username.blank? || skater.password.blank? || Skater.find_by_username(params[:username])
            flash[:warning] = "Invalid, try again."
            redirect '/signup'
        else 
            skater.save
            session[:skater_id] = skater.id # logging user in
            redirect '/posts'
        end 
    end


    get '/login' do # render the login form
        erb :"skaters/login"
    end 

    post '/login' do 
        skater = Skater.find_by_username(params[:username])
        # binding.pry
        # if user exists && password is correct
        if skater && skater.authenticate(params[:password])
            # login user
            session[:skater_id] = skater.id
            # redirect 
            redirect '/posts'
        else 
            flash[:warning] = "Invalid login, please try again."
            # invalid login
            redirect '/login'
        end 
    end 

    get '/logout' do
        session.clear
        redirect '/signup'
    end 


end 