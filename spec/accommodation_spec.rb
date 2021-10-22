require 'accommodation'
require 'user_access'

describe Accommodation do
    subject(:accommodation){described_class.new(1, 2, 'My Cottage', '2 bedroom cottage', 50)}
    describe '#initialize' do
        it 'Should be an instance of Accommodation' do
            expect(accommodation.class).to eq Accommodation
            expect(accommodation).to have_attributes(
                :accommodation_id => 1,
                :owner_id => 2,
                :name => 'My Cottage', 
                :description => '2 bedroom cottage',
                :price_per_night => 50,
              )
        end
    end

    describe '#create' do
        it 'Should create a new accommodation' do
            new_user = UserAccess.register('troy','snowdon')
            new_accommodation = Accommodation.create(new_user.user_id, "My Villa", "4 Bed", 100)
            expect(new_accommodation.class).to eq (Accommodation)
            expect(new_accommodation.name).to eq "My Villa"
            expect(new_accommodation.price_per_night.to_i).to be 100
        end
    end
end