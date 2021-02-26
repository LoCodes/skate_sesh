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

    get '/posts/:id' do 
        #get_post
        @post = Post.find(params[:id])
        erb :'posts/show'
         # # retrieve the requested post 
         # @post = Post.find(params[:id])
         # # show details of that post         
         # erb :'posts/show'
    end 

    get '/posts/:id/edit' do 
        @post = Post.find(params[:id])
        # redirect_if_not_authorized
        erb :"/posts/edit"
        # retreive the object
        # autofill a form with the details of that object
        # render to our user to fill out 
    end 


end  