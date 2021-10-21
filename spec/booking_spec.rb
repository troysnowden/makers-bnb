require 'database_helpers'
require 'booking'

describe Booking do
  describe '#initialize' do
    it 'should be an instance of booking' do
      expect(described_class.new(123456, 654321, '01/02/2022', 80).class).to eq(Booking)
    end

    it 'should initalize with correct attributes' do
      test_booking = described_class.new(123456, 654321, '01/02/2022', 80)

      expect(test_booking).to have_attributes(
        visitor_id: 123456,
        accommodation_id: 654321,
        booked_date: '01/02/2022',
        total_cost: 80,
        confirmed: false
      )
    end
  end

  describe '#confirm' do
    it 'should change confirmed from true to false' do
      test_booking = described_class.new(123456, 654321, '01/02/2022', 80)

      expect do
        test_booking.confirm
      end.to change {
        test_booking.confirmed
      }.from(false).to(true)
    end
  end

  # describe '.create' do
  #   it 'creates a new booking' do
  #     booking = Booking.create(visitor_id: '123456', accommodation_id: '654321', booked_date: '2021-10-21', total_cost: 80)
  #     persisted_data = persisted_data(id: booking.id)

  #     expect(booking).to be_a Booking
  #     expect(booking.id).to eq persisted_data['id']
  #     expect(booking.visitor_id).to eq '123456'
  #     expect(booking.accommodation_id).to eq '654321'
  #     expect(booking.confirmed).to eq True
  #     expect(booking.total_cost).to eq 80
  #   end
  # end

end
