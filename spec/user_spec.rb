require 'user'

describe User do
    describe "#initialize" do
      it "should be an instance of user" do
        expect(described_class.new(01,'tom','s').class).to eq(User)
      end

      it "should initalize with correct attributes" do
        test_booking = described_class.new(01,'tom','s')
        expect(test_booking.user_ID).to eq 01
        expect(test_booking.first_name).to eq "tom"
        expect(test_booking.last_name).to eq "s"

  
        # expect(test_booking).to have_attributes(
        #   :accom_id => 1,
        #   :visitor_id => 2,
        #   :total_cost => 10, 
        #   :arrival_date => '01/02/2022',
        #   :departure_date => '11/02/2022',
        #   :confirmed => false
        # )
      end
    end 
end       