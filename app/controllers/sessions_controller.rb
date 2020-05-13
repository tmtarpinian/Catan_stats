class SessionsController < ApplicationController
    get '/login' do
        erb :'sessions/login'
    end

    post '/login' do
        @user = User.find_by(email: params[:email])                     #could validate this further with logged_in?
        if @user && @user.authenticate(params[:password])
            session[:user_id] = @user.id 
            redirect "/users"
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
