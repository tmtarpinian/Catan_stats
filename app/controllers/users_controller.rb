class UsersController < ApplicationController

    get '/signup' do
        erb :'users/signup'
    end

    post '/signup' do
        @user = User.new(params)
            if @user.save
                session[:user_id] = @user.id
                redirect "/users"
            else
                erb :'users/signup'
            end                                            
    end

    get '/users' do         #show
        if logged_in?
           
            titles = current_user.games.map {|g| g.name}
            u = titles.uniq
            @freq_game = u.max_by {|i| titles.count(i)}     #returns most frequently occuring title
            @frequency = titles.count{|x| x == @freq_game}
            # count = @game.turns.count
            
            # @length = @game.turns.count
            #      if @length >= 1
            #          x = @game.turns.all.group(:result).count
            #          @top_roll = x.sort_by{|k, v| -v}.first[0]
            #          @times = x.sort_by{|k, v| -v}.first[1]
                    
            #     else
            #        @top_roll = "No Data"
            #        @times = 0
            #     end
            erb :"/users/show"
        else
           redirect '/login'
        end 
    end

    get '/users/edit' do         #edit              
        if logged_in?
            erb :"users/edit"
        else
            redirect '/login'
        end
    end

    patch '/users' do            #update                    
        if logged_in?
            @user = current_user
            if params[:name].empty? || params[:email].empty?
                redirect "/users/edit"                      
            else
                @user.update(name: params[:name], email: params[:email])
                redirect "/users"
            end
        else
            redirect '/login'
        end
    end

    delete '/users' do          #delete   
        if logged_in?                 
            @user = current_user
            @user.destroy
            session.clear
            redirect to '/'
        else
            redirect '/login'
        end
    end

end
