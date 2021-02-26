class PostsController < ApplicationController

    get '/posts' do 
        @posts = Post.all
        erb :'posts/index'
    end 

    # get '/posts/new' do 
    #     erb :'posts/new'
    # end 

    get '/posts/new' do
        if logged_in?
          erb :'posts/new'
        else
          redirect to '/login'
        end
    end

    post '/posts' do 
        @post = Post.new(params)
        @post.skater_id = session[:post_id]
        @post.save 
        redirect "/posts/#{@post.id}" 

    end 


end  