class SessionsController < ApplicationController
    get '/' do
        erb :'/users/index'
       end
   
       get '/login' do
           
           erb :'sessions/login'
       end
   
       post '/login' do
           @user = User.find_by(email: params[:email])
           if @user
               session[:user_id] = @user.id 
               binding.pry
               redirect "/users/#{@user.id}"
               
           end
           redirect '/login'
       end
   
       get '/logout' do
           if logged_in?
               session.clear
               redirect '/login'
           else
               redirect '/'
           end
       end
   
       get '/users/:id' do                              #####UPDATE THIS CONTROLLER ACTION
           @user = User.find_by(params[:id])
           erb :'/users/show'
       end
end