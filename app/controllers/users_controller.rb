class UsersController < ApplicationController

    get '/users' do                         ####DELETE THIS ACTION WHEN DONE WITH DEVELOPMENT
        @users = User.all
        @games = Game.all
        erb :'users/index'
    end

    get '/signup' do
        
            erb :'users/signup'
        
    end

    post '/signup' do
        @user = User.new(params)
            if @user.save
                session[:user_id] = @user.id
                redirect "/users/#{@user.id}"
            else
                redirect '/signup'
            end
    end

    get '/users/:id' do         #show
        @user = User.find_by_id(params[:id])
        if !logged_in? 
        redirect '/login'
        end 
        erb :"/users/show"
    end

    get '/users/:id/edit' do         #edit
        @user = User.find_by_id(params[:id])
        erb :"users/edit"
    end

    patch '/users/:id' do            #update
        @user = User.find_by_id(params[:id])
        if params[:name].empty? || params[:email].empty?
            redirect "/users/#{@user.id}/edit"
        else
            @user.update(name: params[:name], email: params[:email])
            redirect "/users/#{@user.id}"
        end
    end

    delete '/users/:id' do          #delete
        @user = User.find_by_id(params[:id])
        @user.destroy
        redirect to '/'
    end

end
