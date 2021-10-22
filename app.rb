require 'sinatra'
require 'sinatra/reloader' if development?
require './lib/user_access'
require './lib/accommodation_access'

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

  get "/register" do
    erb(:registration)
  end

  post "/register" do
    new_user = UserAccess.register(params[:first_name], params[:last_name])
    session[:user] = UserAccess.login(new_user.first_name, new_user.last_name)
    redirect "/"
  end

  get "/login" do
    erb(:login)
  end

  post "/login" do
    session[:user] = UserAccess.login(params[:first_name], params[:last_name])
    redirect "/login" if session[:user].nil? # add flash at some point to signify incorrect details
    redirect "/"
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

  post "/manage-accommodation" do
    # add accommodation to db
    redirect "/manage-accommodation"
  end

  get "/add-accommodation" do
    erb :add_accommodation
  end

  post "/add-accommodation" do
    # add accommodation to db
  end

  get "/book-accommodation" do
    # this will be replaced with db call 
    @test_accoms = AccommodationAccess.all_available_within_max_price_on_date(250, "2021-10-25")
    erb :book_accommodation
  end

  post "/book-accommodation" do
    session[:selected_booking] = AccommodationAccess.all_available_within_max_price_on_date(250, "2021-10-25").select { |key, value| 
       key.accommodation_id.to_i == params[:id].to_i
    }[0]

    # actually redirect to the confirm booking screen
    
    redirect "/"
  end

  get "/view-bookings" do
    erb :view_bookings
  end

end