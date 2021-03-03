class SkatersController < ApplicationController


    get '/signup' do 
        erb :'skaters/signup'
    end 

    post '/signup' do
        skater = Skater.new(params)

        if skater.username.blank? || skater.password.blank? || Skater.find_by_username(params[:username])
            flash[:warning] = "Invalid, try again."
            redirect '/signup'
        else 
            skater.save
            session[:skater_id] = skater.id 
            redirect '/posts'
        end 
    end


    get '/login' do 
        erb :"skaters/login"
    end 

    post '/login' do
        skater = Skater.find_by_username(params[:username])

        if skater && skater.authenticate(params[:password])
            session[:skater_id] = skater.id
            redirect '/posts'
            
        else 
            flash[:warning] = "Invalid login, please try again."
            redirect '/login'
        end 
    end 

    get '/logout' do
        session.clear
        redirect '/'
    end 


end 