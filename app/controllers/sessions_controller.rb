class SessionsController < ApplicationController
    get '/' do
        erb :'/users/index'
       end
   
       get '/login' do
           if logged_in?
               redirect '/users'
           end
           erb :'sessions/login'
       end
   
       post '/login' do
           @user = User.find_by(email: params[:email])
           if user && user.authenticate(params[:password])
               session[:user_id] = @user.id 
               redirect "/users/#{@user.id}"
           end
           redirect '/login'
       end
   
       get '/signup' do
           if logged_in?
               redirect "/users/#{@user.id}"
           end
               erb :'/sessions/signup'
       end
   
       post '/signup' do  
          unless params[:name] == "" || params[:email] == ""
           @user = User.new(params) 
               if user.save
               session[:user_id] = @user.id
               redirect "/users/#{@user.id}"
               end
           end
           redirect '/signup'
       
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
