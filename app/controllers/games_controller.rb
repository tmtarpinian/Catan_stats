class GamesController < ApplicationController
 
    get '/games/new' do         #new
        if logged_in? 
            erb :"/games/new"
        else
            redirect '/login'
        end 
    end

    get '/games/:id' do         #show
        if logged_in? 
            @game = current_user.games.find_by_id(params[:id])
            if @game
                erb :"/games/show"
            else
            redirect '/users'                   
            end
        else
            redirect '/login'
        end 
    end

    post '/games' do         #create
        if logged_in?
            @game = Game.new(name: params[:name])
            @game.build_user(id: current_user.id)
            @game.save
            redirect "/games/#{@game.id}"
        else
            redirect '/users'
        end
    end

    get '/games/:id/edit' do         #edit
    
    end

    patch '/games/:id' do            #update
      
    end

    delete '/games/:id' do          #delete
        @game = Game.find_by_id(params[:id])
        @game.destroy
        redirect '/users'                         
    end
end