require 'booking'

describe Booking do
  describe '#initialize' do
    it 'should be an instance of booking' do
      expect(described_class.new(1, 1, 2, 10, '01/02/2022', 'f').class).to eq(Booking)
    end

    it 'should initalize with correct attributes' do
      test_booking = described_class.new(1, 1, 2, 10, '01/02/2022', 'f')

      expect(test_booking).to have_attributes(
        booking_id: 1,
        visitor_id: 1,
        accommodation_id: 2,
        total_cost: 10,
        date: '01/02/2022',
        confirmed: false
      )
    end
  end
end
