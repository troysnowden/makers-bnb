require 'booking_access'
require 'booking'
require 'accommodation'
require 'user'

describe BookingAccess do

  let(:user) { UserAccess.register('John', 'Smith')}
  let(:accommodation) { AccommodationAccess.create(Accommodation.new())}
  let(:booking) {Booking.new(accommodation.id, user.user_id, accommodation.price_per_night, "08/09/2022")}
  
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
    end
  end

  describe '#confirm_booking_when_request_accepted' do

  end

  describe '#delete_booking_when_request_denied' do

  end
end