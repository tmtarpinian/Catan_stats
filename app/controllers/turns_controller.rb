class TurnsController < ApplicationController
    get 'games/:id/turns/new' do         #new
       binding.pry
            @game = current_user.games.find_by_id(params[:id])
            binding.pry
            erb :"/turns/new"
        
    end

    post '/games/:id/turns' do         #create
        @game = current_user.games.find_by_id(params[:id])
        @turn = Turn.new(result: params[:result])
        @turn.game_id = @game.id
        @turn.save
        #@turn.build_game(id: @game.id)                                
        redirect "/games/#{@game.id}"
    end

    get '/turns/:id/edit' do         #edit
        @game = current_user.games.find_by_id(params[:id])
        @turn = current_user.games.turns.find_by_id(params)
        binding.pry
        erb :'turns/edit'
    end

    patch '/turns/:id' do            #update
      
    end
end