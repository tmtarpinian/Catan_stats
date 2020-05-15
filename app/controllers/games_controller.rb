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
                @length = @game.turns.count
                     if @length >= 1
                         x = @game.turns.all.group(:result).count
                         @top_roll = x.sort_by{|k, v| -v}.first[0]
                         @times = x.sort_by{|k, v| -v}.first[1]
                        
                    else
                       @top_roll = "No Data"
                       @times = 0
                     end
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
            @game = current_user.games.build(name: params[:name])
            @game.save
            redirect "/games/#{@game.id}"
        else
            redirect '/login'
        end
    end

    get '/games/:id/edit' do         #edit
        if logged_in?
            @game = current_user.games.find_by_id(params[:id])
            erb :'/games/edit'
        else
            redirect '/login'
        end  
    end

    patch '/games/:id' do            #update
        if logged_in?
            @game = current_user.games.find_by_id(params[:id])
            @game.update(status: params[:status])
            redirect "/games/#{@game.id}"
        else
            redirect '/login'
        end 
    end

    delete '/games/:id' do          #delete
        if logged_in?
            @game = current_user.games.find_by_id(params[:id])
            @game.destroy
            redirect '/users'      
        else
            redirect '/login'
        end                   
    end
end