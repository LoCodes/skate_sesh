class PostsController < ApplicationController

    get '/posts' do 
        if logged_in?
            @posts = Post.all
            erb :'posts/index'
        else 
            erb :welcome
        end 
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
        get_post
        # @post = Post.find_by(id:params[:id])
        erb :'posts/show'
         # # retrieve the requested post 
         # @post = Post.find(params[:id])
         # # show details of that post         
         # erb :'posts/show'
    end 

    get '/posts/:id/edit' do 
        #if logged in 
        get_post
        # @post = Post.find_by(id: params[:id])
        redirect_if_not_authorized
        erb :"/posts/edit"
        # retreive the object
        # autofill a form with the details of that object
        # render to our user to fill out 
    end 

    patch '/posts/:id' do 
        get_post
        # @post = Post.find_by(id:params[:id])

        #if logged in 
        redirect_if_not_authorized
        @post.update(trick_to_learn: params[:trick_to_learn], description: params[:description])
        redirect "/posts/#{@post.id}" 
        # @post.update
        # no view 
        # update the particular object with new attributes
    end 

    # user wants to delete an existing post 
    delete '/posts/:id' do 
        get_post
        # @post = Post.find_by(id:params[:id])


        @post.destroy
        redirect '/posts'
        # no view 
    end 


private 

    def get_post 
        @post = Post.find_by(id:params[:id])
    end 

    def redirect_if_not_authorized
        if @post.skater != current_user
            flash[:error] = "You may not edit other skaters' post :)"
            redirect '/posts'
        end 

    end     
    


end  