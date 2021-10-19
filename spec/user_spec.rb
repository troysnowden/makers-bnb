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

      end

      it "should check for method bookings" do
        test_booking = described_class.new(01,'tom','s')

        expect(test_booking).to respond_to :bookings
      end 

      it "should check for method all_accommodation" do
        test_booking = described_class.new(01,'tom','s')

        expect(test_booking).to respond_to :all_accommodation
      end 


      it "should check for method approve_booking" do
        test_booking = described_class.new(01,'tom','s')

        expect(test_booking).to respond_to :approve_booking
      end 
    
    end 
end       