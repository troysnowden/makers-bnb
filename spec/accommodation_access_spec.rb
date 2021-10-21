require 'accommodation_access'
require 'user_access'
require 'user'
require 'booking_access'

describe AccommodationAccess do
  
  let(:accommodation) { double :accommodation }
  let(:new_user) { UserAccess.register("John", "Smith") }
  let(:not_our_user) { UserAccess.register("John", "Doe") }

  describe '#all_owned_by_user' do
    it 'should return an empty array when user has no created accommodations' do
      expect(AccommodationAccess.all_owned_by_user(new_user).length).to eq(0)
    end

    it 'should return an array with one accommodation object when user has one created accommodation' do
      AccommodationAccess.create(new_user, "My accommodation", "Brief description", 30)
      
      accommodations = AccommodationAccess.all_owned_by_user(new_user)
      expect(accommodations.length).to eq(1)
      expect(accommodations[0].name).to eq("My accommodation")
      expect(accommodations[0].description).to eq("Brief description")
      expect(accommodations[0].price_per_night).to eq("30.00")
    end

    it 'should not return any accommodations not owned by user' do
      # Accommodation that should not be returned by this method
      AccommodationAccess.create(not_our_user, "Not My accommodation", "Brief description", 30)

      # Accommodation that should be returned by this method
      AccommodationAccess.create(new_user, "My accommodation", "Brief description", 30)
      
      accommodations = AccommodationAccess.all_owned_by_user(new_user)
      expect(accommodations.length).to eq(1)
      expect(accommodations[0].name).to eq("My accommodation")
      expect(accommodations[0].description).to eq("Brief description")
      expect(accommodations[0].price_per_night).to eq("30.00")
    end
  end

  describe '#all_available_within_max_price_on_date' do
    it 'should return only accommodation below the given max price' do
      # Accommodation that should not be returned by this method
      AccommodationAccess.create(not_our_user, "Not valid accommodation", "Brief description", 70)

      # Accommodation that should be returned by this method
      AccommodationAccess.create(new_user, "Valid accommodation", "Brief description", 60)

      accommodations = AccommodationAccess.all_available_within_max_price_on_date(60, "08/09/2022")
      expect(accommodations.length).to eq(1)
      expect(accommodations[0].name).to eq("Valid accommodation")
      expect(accommodations[0].description).to eq("Brief description")
      expect(accommodations[0].price_per_night).to eq('60.00')
    end

    it 'should return only accommodation available on date given' do
      # Accommodation that should not be returned by this method, as it will not be available on the date passed in
      new_accom = AccommodationAccess.create(not_our_user, "Unavailable accommodation", "Brief description", 30)
      # Booking.create() and pass in new_accom.id
      booking_to_confirm = BookingAccess.create(
        not_our_user.user_id, new_accom.accommodation_id, new_accom.price_per_night, "2022-09-08")
      BookingAccess.confirm_booking_when_request_accepted(booking_to_confirm.booking_id)

      # Accommodation that should be returned by this method
      AccommodationAccess.create(new_user, "Valid accommodation", "Brief description", 30)

      accommodations = AccommodationAccess.all_available_within_max_price_on_date(60, "2022-09-08")
      expect(accommodations.length).to eq(1)
      expect(accommodations[0].name).to eq("Valid accommodation")
      expect(accommodations[0].description).to eq("Brief description")
      expect(accommodations[0].price_per_night).to eq('30.00')
    end
  end

  describe '#create' do
    it 'should add a new accommodation to the accommodations table' do
      expect{
        AccommodationAccess.create(new_user, "My accommodation", "Brief description", 30)
      }.to change{AccommodationAccess.all_available_within_max_price_on_date(60, "08/09/2022").length}.by(1)
      created_accommodation = AccommodationAccess.create(new_user, "My accommodation", "Brief description", 30)
      expect(created_accommodation.class).to eq(Accommodation)
      expect(created_accommodation.name).to eq "My accommodation"
      expect(created_accommodation.description).to eq "Brief description"
      expect(created_accommodation.price_per_night).to eq('30.00')
    end
  end
end