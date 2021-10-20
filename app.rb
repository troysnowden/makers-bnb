require 'sinatra'
require 'sinatra/reloader' if development?

class MakersBnb < Sinatra::Base
  
  # :nocov:
  configure :development do
    register Sinatra::Reloader
  end
  # :nocov:

  get "/" do # index page
    erb (:index)
  end

  get "/register" do
    erb(:registration)
  end

  post "/register" do
    "Hello!"
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