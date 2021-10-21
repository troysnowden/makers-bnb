require 'booking_access'
require 'booking'
require 'accommodation'
require 'accommodation_access'
require 'user'

describe BookingAccess do

  let(:user) { UserAccess.register('John', 'Smith')}
  let(:not_our_user) { UserAccess.register("John", "Doe") }
  let(:accommodation) { AccommodationAccess.create(not_our_user, "My accommodation", "Brief description", 30) }
  let(:accommodation_user_owns) { AccommodationAccess.create(user, "User's accommodation", "Brief description", 50) }
  let(:booking) { BookingAccess.create(user.user_id, accommodation.accommodation_id, accommodation.price_per_night, "2022-08-19") }
  
  describe '#all_requests_for_accommodation_owner' do
    it 'should only return requests made to accommodation owned by user' do
      # Booking that should be returned by method, as made for accommodation that user owns
      BookingAccess.create(not_our_user.user_id, accommodation_user_owns.accommodation_id, 
      accommodation_user_owns.price_per_night, "2022-08-29")
      
      # Booking that should not be returned by method, as booking has been confirmed
      booking_to_confirm = BookingAccess.create(not_our_user.user_id, 
      accommodation_user_owns.accommodation_id, accommodation_user_owns.price_per_night, "2022-08-29")
      BookingAccess.confirm_booking_when_request_accepted(booking_to_confirm.booking_id)
      
      # Booking that should not be returned by method, as not made for accommodation that user owns
      BookingAccess.create(not_our_user.user_id, accommodation.accommodation_id, accommodation.price_per_night, "2022-08-19")

      user_booking_requests = BookingAccess.all_requests_for_accommodation_owner(user.user_id)
      expect(user_booking_requests.length).to eq(1)
      expect(user_booking_requests[0].visitor_id).to eq not_our_user.user_id
      expect(user_booking_requests[0].accommodation_id).to eq accommodation_user_owns.accommodation_id
      expect(user_booking_requests[0].total_cost).to eq accommodation_user_owns.price_per_night
      expect(user_booking_requests[0].date).to eq "2022-08-29"
    end
    
  end

  describe '#all_confirmed_for_accommodation_owner' do
    it 'should only return requests made to accommodation owned by user' do
      # Booking that should be returned by method, as made for accommodation that user owns and confirmed
      booking_to_confirm = BookingAccess.create(not_our_user.user_id, accommodation_user_owns.accommodation_id, accommodation_user_owns.price_per_night, "2022-08-29")
      BookingAccess.confirm_booking_when_request_accepted(booking_to_confirm.booking_id)
      
      # Booking that should not be returned by method, as not made for accommodation that user owns, even if confirmed
      booking_to_confirm = BookingAccess.create(not_our_user.user_id, accommodation.accommodation_id, accommodation.price_per_night, "2022-08-19")
      BookingAccess.confirm_booking_when_request_accepted(booking_to_confirm.booking_id)

      # Booking that should not be returned by method, as not made for accommodation that user owns and not confirmed
      BookingAccess.create(not_our_user.user_id, accommodation.accommodation_id, accommodation.price_per_night, "2022-08-19")

      # Booking that should not be returned by method, as not confirmed even though made for accommodation that user owns
      BookingAccess.create(not_our_user.user_id, accommodation_user_owns.accommodation_id, accommodation_user_owns.price_per_night, "2022-08-19")
      


      user_booking_requests = BookingAccess.all_confirmed_for_accommodation_owner(user.user_id)
      expect(user_booking_requests.length).to eq(1)
      expect(user_booking_requests[0].visitor_id).to eq not_our_user.user_id
      expect(user_booking_requests[0].accommodation_id).to eq accommodation_user_owns.accommodation_id
      expect(user_booking_requests[0].total_cost).to eq accommodation_user_owns.price_per_night
      expect(user_booking_requests[0].date).to eq "2022-08-29"
    end
  end

  describe '#all_requests_for_visitor' do
    it 'should only return booking requests made by the user passed into the method' do
      # A booking made that should not be returned by the user calling the method
      BookingAccess.create(not_our_user.user_id, accommodation.accommodation_id, accommodation.price_per_night, "2022-08-29")

      BookingAccess.create(user.user_id, accommodation.accommodation_id, accommodation.price_per_night, "2022-08-19")

      user_booking_requests = BookingAccess.all_requests_for_visitor(user.user_id)
      expect(user_booking_requests.length).to eq(1)
      expect(user_booking_requests[0].visitor_id).to eq user.user_id
      expect(user_booking_requests[0].accommodation_id).to eq accommodation.accommodation_id
      expect(user_booking_requests[0].total_cost).to eq accommodation.price_per_night
      expect(user_booking_requests[0].date).to eq "2022-08-19"
    end
  end

  describe '#all_confirmed_for_visitor' do
    it 'should only return booking requests made by the user passed into the method' do
      # A booking made that should not be returned by the user calling the method
      new_booking = BookingAccess.create(not_our_user.user_id, accommodation.accommodation_id, accommodation.price_per_night, "2022-08-29")
      BookingAccess.confirm_booking_when_request_accepted(new_booking.booking_id)

      BookingAccess.confirm_booking_when_request_accepted(booking.booking_id)
      
      user_booking_requests = BookingAccess.all_confirmed_for_visitor(user.user_id)
      expect(user_booking_requests.length).to eq(1)
      expect(user_booking_requests[0].visitor_id).to eq user.user_id
      expect(user_booking_requests[0].accommodation_id).to eq accommodation.accommodation_id
      expect(user_booking_requests[0].total_cost).to eq accommodation.price_per_night
      expect(user_booking_requests[0].date).to eq "2022-08-19"
    end

    it 'should only return confirmed booking requests made by the user passed into the method' do
      # A new booking made that should not be returned by the method, not confirmed
      BookingAccess.create(user.user_id, accommodation.accommodation_id, accommodation.price_per_night, "2022-08-29")

      BookingAccess.confirm_booking_when_request_accepted(booking.booking_id)
      user_booking_requests = BookingAccess.all_confirmed_for_visitor(user.user_id)
      expect(user_booking_requests.length).to eq(1)
      expect(user_booking_requests[0].visitor_id).to eq user.user_id
      expect(user_booking_requests[0].accommodation_id).to eq accommodation.accommodation_id
      expect(user_booking_requests[0].total_cost).to eq accommodation.price_per_night
      expect(user_booking_requests[0].date).to eq "2022-08-19"
    end
  end

  describe '#create' do
    it 'should create a booking request for visitor' do
      BookingAccess.create(user.user_id, accommodation.accommodation_id, accommodation.price_per_night, "2022-08-19")
      expect(booking.class).to eq Booking
      expect(booking.accommodation_id).to eq accommodation.accommodation_id
      expect(booking.visitor_id).to eq user.user_id
      expect(booking.total_cost).to eq accommodation.price_per_night
      expect(booking.date).to eq "2022-08-19"
    end
  end

  describe '#confirm_booking_when_request_accepted' do
    it 'should change confirmed status of booking from false to true' do
      expect(booking.confirmed).to eq(false)
      confirmed_booking = BookingAccess.confirm_booking_when_request_accepted(booking.booking_id)
      expect(confirmed_booking.confirmed).to eq(true)
    end
  end

  describe '#delete_booking_when_request_denied' do
    it 'should remove the booking request for the user that submitted it' do
      booking_to_delete = BookingAccess.create(user.user_id, accommodation.accommodation_id, accommodation.price_per_night, "2022-08-19")

      expect(BookingAccess.all_requests_for_visitor(user.user_id).length).to eq 1
      BookingAccess.delete_booking_when_request_denied(booking_to_delete.booking_id)
      expect(BookingAccess.all_requests_for_visitor(user.user_id).length).to eq 0
    end
  end
end