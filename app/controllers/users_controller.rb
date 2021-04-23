class UsersController < ApplicationController

    get '/signup' do
        slim :'users/signup'
    end

    post '/signup' do
        @user = User.new(params)
            if @user.save
                session[:user_id] = @user.id
                redirect "/profile"
            else
                erb :'users/signup'
            end                                            
    end

    get '/profile' do
        if logged_in?
            titles = current_user.games.map {|g| g.name}
            u = titles.uniq
            @freq_game = u.max_by {|i| titles.count(i)}     #returns most frequently occuring title
            @frequency = titles.count{|x| x == @freq_game}
            
            erb :"users/profile"
        else
           redirect '/login'                               
        end 
    end

    get '/users/edit' do           
        if logged_in?
            erb :"users/edit"
        else
            redirect '/login'
        end
    end

    patch '/users' do          
        if logged_in?
            @user = current_user
            if params[:name].empty? || params[:email].empty?
                redirect "/users/edit"                      
            else
                @user.update(name: params[:name], email: params[:email])
                redirect "/profile"
            end
        else
            redirect '/login'
        end
    end

    delete '/users' do
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
