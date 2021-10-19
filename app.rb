require 'sinatra'
require 'sinatra/reloader' if development?

class MakersBnb < Sinatra::Base
  
  # :nocov:
  configure :development do
    register Sinatra::Reloader
  end
  # :nocov:

  get "/" do # index page
    "Home page containing manage my accommodation link"
  end

  get "/register" do
    "Register page containing form and submit button"
  end

  post "/register" do
    # adds user to db
  end

  get "/manage-accommodation" do
    "Page containing list of user's accommodations and add accommodation button"
  end

  get "/add-accommodation" do
    "Containing form with accommodation details to fill out and submit button"
  end

  post "/add-accommodation" do
    # add accommodation to db
  end

end