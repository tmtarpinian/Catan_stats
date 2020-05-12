require './config/environment'

class ApplicationController < Sinatra::Base

  configure do
    set :public_folder, 'public'
    set :views, 'app/views'
    enable :sessions
    set :session_secret, 'password_security'
    
  end

  get "/" do
    @users = User.all                   #Delete lines 14-16 after production
    @games = Game.all
    @turns = Turn.all
    erb :welcome
  end

  helpers do

    def logged_in?
      !!session[:user_id]
    end

    def current_user
      @user ||= User.find_by_id(session[:user_id]) if logged_in?
    end

  end

end
