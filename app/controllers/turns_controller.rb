class TurnsController < ApplicationController
    get '/games/:id/turns/new' do         #new
        if logged_in? 
            erb :"/turns/new"
        else
            redirect '/login'
        end 
    end

    post '/games/:id/turns' do         #create
        #need to find game in my games, otherwise bounce
        #@turn = current_user.games.build(params)



        @turn = Turn.build(name: params[:result])
        @turn[:game_id] = session[:user_id]                     #need current game ID
        @turn.save 
        redirect "/games/#{@game.id}"
    end

    get '/turns/:id/edit' do         #edit
        erb :'turns/edit'
    end

    patch '/turns/:id' do            #update
      
    end
end