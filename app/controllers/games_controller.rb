class GamesController < ApplicationController
    
    get '/games' do         #index
        @games = Game.all
        erb :"/games/index"
    end

    get '/games/new' do         #new
        @user = User.find_by_id(params[:id])
        if !logged_in? 
        redirect '/login'
        end 
        erb :"/games/new"
    end

    get '/games/:id' do         #show
        @user = User.find_by_id(params[:id])
        @game = @user.games.find_by_id(params[:id])
        
        erb :"/games/show"
    end

    post '/games' do         #create
        unless params[:name] == ""
            @game = Game.new(name: params[:name])
            @game[:user_id] = session[:user_id]
            @game.save  
            redirect "/games/#{@game.id}"
        end
        redirect '/games/new'
    end

    get '/games/:id/edit' do         #edit
    
    end

    patch '/games/:id' do            #update
      
    end

    delete '/games/:id' do          #delete
        @game = Game.find_by_id(params[:id])
        @game.destroy
        redirect "/users/#{@user.id}"
    end
end