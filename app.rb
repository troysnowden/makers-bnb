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
    $test_accoms = [
      {:name => "Sunny Sands", :description => "coarse and rough", :price => "80", :id => 1},
      {:name => "Coastal Chalet", :description => "nice pillows", :price => "1000", :id => 2},
      {:name => "Riviera Retreat", :description => "great apart from the smell", :price => "300", :id => 3}
    ]
    @test_accoms = $test_accoms
    erb :book_accommodation
  end

  post "/book-accommodation" do
    session[:selected_booking] = $test_accoms.select { |key, value| 
       key[:id].to_i == params[:id].to_i
    }[0]

    redirect "/"
  end

  get "/view-bookings" do
    erb :view_bookings
  end

end