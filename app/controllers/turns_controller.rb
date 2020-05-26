class TurnsController < ApplicationController

    post '/games/:id/turns' do
        if logged_in?
            @game = current_user.games.find_by_id(params[:id])
            @turn = @game.turns.build(result: params[:result])   
            @turn.save                            
            redirect "/games/#{@game.id}"
        else
            redirect '/login'
        end
    end

    get '/games/:game_id/turns/:id/edit' do
        if logged_in?
            @game = current_user.games.find_by_id(params[:game_id])
            @turn = @game.turns.find_by_id(params[:id])
            erb :'turns/edit'
        else
            redirect '/login'
        end
    end
        
    patch '/games/:game_id/turns/:id' do
        if logged_in?
            @game = current_user.games.find_by_id(params[:game_id])
            @turn = @game.turns.find_by_id(params[:id])
            @turn.update(result: params[:result])
            redirect "/games/#{@game.id}"
        else
            redirect '/login'
        end                       
    end

    delete '/games/:game_id/turns/:id' do
        if logged_in?
            @game = current_user.games.find_by_id(params[:game_id])
            @turn = @game.turns.find_by_id(params[:id])
            @turn.destroy
            redirect "/games/#{@game.id}"
        else
            redirect '/login'
        end                     
    end
end