require 'accommodation'

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
end