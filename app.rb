require 'sinatra'
require 'sinatra/reloader' if development?
require './lib/user_access'
require './lib/accommodation_access'
require './lib/booking_access'
require './lib/accommodation'


class MakersBnb < Sinatra::Base

  enable :sessions
  
  # :nocov:
  configure :development do
    register Sinatra::Reloader
  end
  # :nocov:

  get "/" do # index page
    @user = session[:user] unless session[:user].nil?
    erb (:index)
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

  get "/manage-accommodation" do
    redirect "/" if session[:user].nil?
    @user_accommodations = AccommodationAccess.all_owned_by_user(session[:user].user_id)
    @booking_requests_owner = BookingAccess.all_requests_for_accommodation_owner(session[:user].user_id)
    @confirmed_booking_requests_owner = BookingAccess.all_confirmed_for_accommodation_owner(session[:user].user_id)
    @accoms_with_booking_reqs = []

    @booking_requests_owner.each do |request| 
      @user_accommodations.each do |accom| 
        @accoms_with_booking_reqs << accom if accom.accommodation_id == request.accommodation_id 
      end
    end

    erb (:manage_accommodation)
  end

  # not sure what this route is for so not deleting it yet incase someone is using it
  # post "/manage-accommodation" do
  #   redirect "/manage-accommodation"
  # end

  get "/add-accommodation" do
    redirect "/" if session[:user].nil?
    erb :add_accommodation
  end

  post "/add-accommodation" do
    user_id = session[:user].user_id
    new_accomodation = AccommodationAccess.create(session[:user].user_id, params[:name], params[:description], params[:price_per_night])
    redirect "/manage-accommodation"
  end

  get "/book-accommodation" do
    redirect "/" if session[:user].nil?
    @test_accoms = AccommodationAccess.all_available_within_max_price_on_date(250, "2021-10-25")
    erb :book_accommodation
  end

  post "/book-accommodation" do
    session[:selected_booking] = AccommodationAccess.all_available_within_max_price_on_date(250, "2021-10-25").select { |key, value| 
       key.accommodation_id.to_i == params[:id].to_i
    }[0]

    # actually redirect to the confirm booking screen
    
    redirect "/confirm-booking"
  end

  get "/confirm-booking" do
    @accom = session[:selected_booking]
    erb(:confirm_booking)
  end

  post "/confirm-booking" do
    confirmed_booking = BookingAccess.create(
      session[:user].user_id,
      session[:selected_booking].accommodation_id,
      session[:selected_booking].price_per_night,
      # hardcoded for now
      "2021-10-23"
    )

    redirect "/"
  end

  get "/view-bookings" do
    user_id = session[:user].user_id
    @request_list = all_requests_for_visitor(user_id)
    @confirmed_list = all_confirmed_for_visitor(user_id)
    @accommodation_id = 
    erb :view_bookings
  end

end