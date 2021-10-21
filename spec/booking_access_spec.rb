require 'booking_access'
require 'booking'
require 'accommodation'
require 'user'

describe BookingAccess do

  let(:user) { UserAccess.register('John', 'Smith')}
  let(:accommodation) { AccommodationAccess.create(user, "My accommodation", "Brief description", 30) }
  
  describe '#all_requests_for_accommodation_owner' do
    
  end

  describe '#all_confirmed_for_accommodation_owner' do
    
  end

  describe '#all_requests_for_visitor' do
    
  end

  describe '#all_confirmed_for_visitor' do
    
  end

  describe '#create' do
    it 'should create a booking request for visitor' do
      new_booking = BookingAccess.create(user.user_id, accommodation.accommodation_id, accommodation.price_per_night, "18/09/2022")
      expect(new_booking.class).to eq Booking
      expect(new_booking.accommodation_id).to eq accommodation.accommodation_id
      expect(new_booking.visitor_id).to eq user.user_id
      expect(new_booking.total_cost).to eq accommodation.price_per_night
      expect(new_booking.date).to eq "2022-08-09"
    end
  end

  describe '#confirm_booking_when_request_accepted' do

  end

  describe '#delete_booking_when_request_denied' do

  end
end