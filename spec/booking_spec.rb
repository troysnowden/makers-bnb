require 'booking'

describe Booking do
  describe "#initialize" do
    it "should be an instance of booking" do
      expect(described_class.new(1,2,10,'01/02/2022','11/02/2022').class).to eq(Booking)
    end

    it "should initalize with correct attributes" do
      test_booking = described_class.new(1,2,10,'01/02/2022','11/02/2022')

      expect(test_booking).to have_attributes(
        :accom_id => 1,
        :visitor_id => 2,
        :total_cost => 10, 
        :arrival_date => '01/02/2022',
        :departure_date => '11/02/2022',
        :confirmed => false
      )
    end
  end

  describe "#confirm" do
    it "should change confirmed from true to false" do
      test_booking = described_class.new(1,2,10,'01/02/2022','11/02/2022')

      expect{
        test_booking.confirm
      }.to change{
        test_booking.confirmed
      }.from(false).to(true)   
    end
  end
end