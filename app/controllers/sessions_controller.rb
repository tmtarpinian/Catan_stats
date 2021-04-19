class SessionsController < ApplicationController
    get '/login' do
        slim :'sessions/login'
    end

    post '/login' do
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id 
            redirect '/profile'
        end
        redirect '/login'
    end

    get '/logout' do
        if logged_in?
            session.clear
            redirect '/'
        else
            redirect '/'
        end
    end
    
end
