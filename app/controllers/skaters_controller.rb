class SkatersController < ApplicationController


    get '/signup' do # render signup form
        erb :'skaters/signup'
    end 

    post '/signup' do
        skater = Skater.new(params)
        # validate our author object
        # if author.username != ""
        if skater.username.blank? || skater.password.blank? || Skater.find_by_username(params[:username])
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


end 