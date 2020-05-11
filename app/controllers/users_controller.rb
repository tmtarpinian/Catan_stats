class UsersController < ApplicationController

    get '/users' do
        @users = User.all
        @games = Game.all
        erb :'users/index'
    end

    get '/users/:id' do         #show
        @user = User.find_by_id(params[:id])
        if !logged_in? 
        redirect '/login'
        end 
        erb :'/users/show'
    end

    get '/users/new' do         #new
       
    end

    post '/users' do             #create
        
    end

    get '/users/:id/edit' do
        
    end

    patch 'users/:id' do
        
    end

    delete '/users/:id' do
    
    end

end