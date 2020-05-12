class GamesController < ApplicationController
 
    get '/games/new' do         #new
        if logged_in? 
            erb :"/games/new"
        else
            redirect '/login'
        end 
    end

    get '/games/:id' do         #show
        @game = current_user.games.find_by_id(params[:id])
        if @game
            erb :"/games/show"
        else
           redirect '/users'                   ######NEED A REDIRECT
        end
    end

    post '/games' do         #create
        @game = Game.new(name: params[:name])
        @game[:user_id] = current_user.id
        @game.save 
        redirect "/games/#{@game.id}"
    end

    get '/games/:id/edit' do         #edit
    
    end

    patch '/games/:id' do            #update
      
    end

    delete '/games/:id' do          #delete
        @game = Game.find_by_id(params[:id])
        @game.destroy
        redirect '/users/:id'                           ##Update this route to /users
    end
end