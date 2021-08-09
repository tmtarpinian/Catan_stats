class GamesController < ApplicationController
 
    get '/games' do
        if logged_in?
            titles = current_user.games.map {|g| g.name}
            u = titles.uniq
            @freq_game = u.max_by {|i| titles.count(i)}     #returns most frequently occuring title
            @frequency = titles.count{|x| x == @freq_game}
            erb :"/games/index"
        else
            redirect '/login'
        end 
    end
    
    get '/games/new' do
        if logged_in? 
            erb :"/games/new"
        else
            redirect '/login'
        end 
    end

    post '/games' do            #create
        if logged_in?
            @game = current_user.games.build(name: params[:name], number_of_players: params[:players])
            @game.save
            redirect "/games/#{@game.id}"
        else
            redirect '/login'
        end
    end

    get '/games/:id/edit' do         
        if logged_in?
            @game = current_user.games.find_by_id(params[:id])
                if @game
                    erb :'/games/edit'
                else
                    redirect '/games'
                end
        else
            redirect '/login'
        end  
    end

    get '/games/:id' do
        if logged_in? 
            @game = current_user.games.find_by_id(params[:id])
            if @game
                games = current_user.games.count
                count = @game.turns.count
                @length = @game.turns.count
                     if @length >= 1
                        x = @game.turns.all.group(:result).count
                        @top_roll = x.sort_by{|k, v| -v}.first[0]
                        
                        @times = x.sort_by{|k, v| -v}.first[1]
                        @percentage = ((@times.to_f/@length)*100).floor(1)
                    else
                        @top_roll = "No Data"
                        @times = 0
                        @percentage = 0
                     end
                erb :"/games/show"
            else
                redirect '/profile'                                   
            end
        else
            redirect '/login'
        end 
    end

    patch '/games/:id' do           
        if logged_in?
            @game = current_user.games.find_by_id(params[:id])
            @game.update(status: params[:status])
            redirect "/games/#{@game.id}"
        else
            redirect '/login'
        end 
    end

    delete '/games/:id' do
        if logged_in?
            @game = current_user.games.find_by_id(params[:id])
            @game.destroy
            redirect '/games'      
        else
            redirect '/login'
        end                   
    end

    private

    def valid_game      
        # refractor the @game code from 63-66 and use in other methods
    end
end