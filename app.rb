require 'sinatra'
require 'sinatra/reloader' if development?
require './lib/user_access'
require './lib/accommodation_access'
require './lib/booking_access'
require './lib/accommodation'
require './lib/booking_access'


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

    # hash with accommodation name as key and booking as value
    @booking_requests_owner_hash = {}
    BookingAccess.all_requests_for_accommodation_owner(session[:user].user_id).each do |request|
      @booking_requests_owner_hash[AccommodationAccess.filter_by_accom_id(request.accommodation_id)[0].name] = request
    end

    # hash with accommodation name as key and booking as value
    @confirmed_bookings_owner_hash = {}
    BookingAccess.all_confirmed_for_accommodation_owner(session[:user].user_id).each do |request|
      @confirmed_bookings_owner_hash[AccommodationAccess.filter_by_accom_id(request.accommodation_id)[0].name] = request
    end

    erb (:manage_accommodation)
  end

  post "/respond-to-booking" do
    p params
    # change to view booking
    if params[:confirm_booking] == "Confirm"
      BookingAccess.confirm_booking_when_request_accepted(params[:booking_id])
    else
      BookingAccess.delete_booking_when_request_denied(params[:booking_id])
    end

    redirect "/manage-accommodation"
  end

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
    @current_chosen_date = session[:current_chosen_date].nil? ? "2021-10-25" : session[:current_chosen_date]
    @current_chosen_max_price = session[:current_chosen_max_price].nil? ? 999 : session[:current_chosen_max_price]
    redirect "/" if session[:user].nil?
    @test_accoms = AccommodationAccess.all_available_within_max_price_on_date(
      @current_chosen_max_price, @current_chosen_date)
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

    # hash with accommodation name as key and booking as value
    @booking_requests_visitor_hash = {}
    BookingAccess.all_requests_for_visitor(session[:user].user_id).each do |request|
      @booking_requests_visitor_hash[AccommodationAccess.filter_by_accom_id(request.accommodation_id)[0].name] = request
    end

    # hash with accommodation name as key and booking as value
    @confirmed_bookings_visitor_hash = {}
    BookingAccess.all_confirmed_for_visitor(session[:user].user_id).each do |request|
      @confirmed_bookings_visitor_hash[AccommodationAccess.filter_by_accom_id(request.accommodation_id)[0].name] = request
    end

    
    erb :view_bookings
  end

  post "/search-specific" do
    session[:current_chosen_date] = params[:calendar]
    session[:current_chosen_max_price] = params[:max_price]
    redirect "/book-accommodation"
  end

end