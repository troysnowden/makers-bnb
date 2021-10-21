require 'accommodation_access'
require 'user_access'
require 'user'

describe AccommodationAccess do
  
  let(:accommodation) { double :accommodation }
  let(:new_user) { UserAccess.register("John", "Smith") }
  let(:not_our_user) { UserAccess.register("John", "Doe") }
  let(:user) { double :user }

  describe '#all_owned_by_user' do
    it 'should return an empty array when user has no created accommodations' do
      expect(AccommodationAccess.all_owned_by_user(new_user).length).to eq(0)
    end

    it 'should return an array with one accommodation object when user has one created accommodation' do
      allow(accommodation).to receive(:owner_id). and_return(new_user.user_id)
      allow(accommodation).to receive(:name). and_return("My accommodation")
      allow(accommodation).to receive(:description). and_return("Brief description")
      allow(accommodation).to receive(:price_per_night). and_return(30)
      AccommodationAccess.create(user, accommodation)
      
      accommodations = AccommodationAccess.all_owned_by_user(new_user)
      expect(accommodations.length).to eq(1)
      expect(accommodations[0].name).to eq("My accommodation")
      expect(accommodations[0].description).to eq("Brief description")
      expect(accommodations[0].price_per_night).to eq("30.00")
    end

    it 'should not return any accommodations not owned by user' do
      # Accommodation that should not be returned by this method
      allow(accommodation).to receive(:owner_id). and_return(not_our_user.user_id)
      allow(accommodation).to receive(:name). and_return("Not My accommodation")
      allow(accommodation).to receive(:description). and_return("Brief description")
      allow(accommodation).to receive(:price_per_night). and_return(30)
      AccommodationAccess.create(user, accommodation)

      # Accommodation that should be returned by this method
      allow(accommodation).to receive(:name). and_return("My accommodation")
      allow(accommodation).to receive(:owner_id). and_return(new_user.user_id)
      AccommodationAccess.create(new_user, accommodation)
      
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
      allow(accommodation).to receive(:owner_id). and_return(not_our_user.user_id)
      allow(accommodation).to receive(:name). and_return("Not valid accommodation")
      allow(accommodation).to receive(:description). and_return("Brief description")
      allow(accommodation).to receive(:price_per_night). and_return(70)
      AccommodationAccess.create(user, accommodation)

      # Accommodation that should be returned by this method
      allow(accommodation).to receive(:name). and_return("Valid accommodation")
      allow(accommodation).to receive(:owner_id). and_return(new_user.user_id)
      allow(accommodation).to receive(:price_per_night). and_return(30)
      AccommodationAccess.create(new_user, accommodation)

      accommodations = AccommodationAccess.all_available_within_max_price_on_date(60, "08/09/2022")
      expect(accommodations.length).to eq(1)
      expect(accommodations[0].name).to eq("Valid accommodation")
      expect(accommodations[0].description).to eq("Brief description")
      expect(accommodations[0].price_per_night).to eq(30)
    end
  end

  describe '#create' do
    it 'should add a new accommodation to the accommodations table' do
      p new_user.user_id
      allow(accommodation).to receive(:owner_id). and_return(new_user.user_id)
      allow(accommodation).to receive(:name). and_return("My accommodation")
      allow(accommodation).to receive(:description). and_return("Brief description")
      allow(accommodation).to receive(:price_per_night). and_return(30)
      expect{AccommodationAccess.create(user, accommodation)}.to change{AccommodationAccess.all_available_within_max_price_on_date(60, "08/09/2022").length}.by(1)
    end
  end
end