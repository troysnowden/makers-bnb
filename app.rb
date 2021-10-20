require 'sinatra'
require 'sinatra/reloader' if development?

class MakersBnb < Sinatra::Base
  
  # :nocov:
  configure :development do
    register Sinatra::Reloader
  end
  # :nocov:

  get "/" do # index page
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
    # adds user to db
  end

  get "/login" do
    erb(:login)
  end

  post "/login" do
    redirect "test-homepage"
    # sets logged in to true
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

  get "/book-accommodation" do
    erb :book_accommodation
  end

  post "/book-accommodation" do
    erb :book_accommodation
  end

end