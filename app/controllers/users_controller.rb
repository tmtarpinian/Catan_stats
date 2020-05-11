class UsersController < ApplicationController

    get '/users' do
        @users = User.all
        @games = Game.all
        erb :'users/index'
    end

    get '/users/:id' do         #show
        
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