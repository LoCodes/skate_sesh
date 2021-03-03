class PostsController < ApplicationController

    get '/posts' do 
        
        if logged_in?
            @posts = Post.all
            @posts = Post.order(created_at: :desc)
            erb :'posts/index'
        else 
            flash[:error] = "Let's get you logged in or sign up first! :)"
            redirect "/"
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

        if params[:description] == "" || params[:trick_to_learn] == "" || params[:accomplished] == ""
            flash[:error] = "Fill the blanks!"
            redirect "/posts/new"
        else 
            @post = Post.new(params)
            @post.skater_id = session[:skater_id]
            @post.save
            redirect "/posts/#{@post.id}"  
        end 
    end 

    get '/posts/:id' do 
        get_post
        erb :'posts/show'
    end 

    get '/posts/:id/edit' do 
        #if logged in 
        get_post
        erb :"/posts/edit"
        # @post = Post.find_by(id: params[:id])
        # if @post.skater == current_user
        #     erb :"/posts/edit"
        # else 
        #     flash[:error] = "You may not edit other skaters' post :)"
        #     redirect '/posts'
        # end
    end 

    patch '/posts/:id' do 
        @post = Post.find_by(id:params[:id])

        if params[:description] == "" || params[:trick_to_learn] == "" || params[:accomplished] == ""
            flash[:error] = "Content must be posted, fill the blanks please."
            redirect "/posts/#{@post.id}/edit"
        else           
            @post.update(trick_to_learn: params[:trick_to_learn], description: params[:description], link: params[:link], accomplished: params[:accomplished])
            redirect "/posts/#{@post.id}" 
        end 
    end 




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
    


end  