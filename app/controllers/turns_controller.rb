class TurnsController < ApplicationController

    

    get '/games/:id/turns/new' do         #new
        #@game = current_user.games.find_by_id(params[:id])
        #binding.pry
        #erb :"/turns/new"
    end

    post '/games/:id/turns' do         #create
        @game = current_user.games.find_by_id(params[:id])
        @turn = @game.turns.build(result: params[:result])   
        @turn.save                            
        redirect "/games/#{@game.id}"
    end

    get '/games/:game_id/turns/:id/edit' do         #edit
        @game = current_user.games.find_by_id(params[:game_id])
        @turn = @game.turns.find_by_id(params[:id])
        erb :'turns/edit'
    end
        
    patch '/games/:game_id/turns/:id' do            #update
        binding.pry
        @game = current_user.games.find_by_id(params[:game_id])
        @turn = @game.turns.find_by_id(params[:id])
        @turn.update(result: params[:result])
        redirect "/games/#{@game.id}"                           
    end

    delete '/games/:game_id/turns/:id' do          #delete
        @game = current_user.games.find_by_id(params[:game_id])
        @turn = @game.turns.find_by_id(params[:id])
        @turn.destroy
        redirect "/games/#{@game.id}"                        
    end
end