require 'sinatra'
require 'sinatra/reloader' if development?
require './lib/user_access'

class MakersBnb < Sinatra::Base

  enable :sessions
  
  # :nocov:
  configure :development do
    register Sinatra::Reloader
  end
  # :nocov:

  get "/" do # index page
    @user = session[:user] unless session[:user].nil?
    # if user.logged_in?
    erb (:index)
    # else
    # erb(:homepage)
  end

  # route to be removed when we can check if a user is logged in
  # just here to aid testing
  get "/test-homepage" do # index page
    # if user.logged_in?
    # erb (:index)
    # else
    erb(:homepage)
  end

  get "/register" do
    erb(:registration)
  end

  post "/register" do
    new_user = UserAccess.register(params[:first_name], params[:last_name])
    session[:user] = UserAccess.login(new_user.first_name, new_user.last_name)
    redirect "/"
  end

  get "/manage-accommodation" do
    erb (:manage_accommodation)
  end

  get "/add-accommodation" do
    erb :add_accommodation
  end

  post "/add-accommodation" do
    # add accommodation to db
  end

end