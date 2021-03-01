class PostsController < ApplicationController

    get '/posts' do 
        
        if logged_in?
            @posts = Post.all
            #@skater = Skater.find_by_username(params[:username]) try this instead?!
            @skaters = Skater.all   #delete later works with .zip in index. 
            erb :'posts/index'
        else 
            erb :welcome
        end 
    end 



    get '/posts/new' do
        if logged_in?
          erb :'posts/new'
        else
          redirect to '/login'
        end
    end

    post '/posts' do 
        @post = Post.new(params)
        @post.skater_id = session[:skater_id]
        

        @post.save 
        redirect "/posts/#{@post.id}" 
    end 

    get '/posts/:id' do 
        get_post
        erb :'posts/show'
    end 

    get '/posts/:id/edit' do 
        #if logged in 
        get_post
        # @post = Post.find_by(id: params[:id])
        if @post.skater == current_user
            erb :"/posts/edit"
        else 
            flash[:error] = "You may not edit other skaters' post :)"
            redirect '/posts'
        end
    end 

    patch '/posts/:id' do 
        @post = Post.find_by(id:params[:id])

        @post.update(trick_to_learn: params[:trick_to_learn], description: params[:description])
        redirect "/posts/#{@post.id}" 
    end 


    #NOT DONE
    get '/mypage' do 
        if current_user
            @posts = Post.all
            
            erb :"/posts/mypage"
        end 

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
            flash[:error] = " "
            redirect '/posts'

        end 
    end     
    


end  