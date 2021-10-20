require 'user'

describe User do
    describe "#initialize" do
    
      it "should be an instance of user" do
        expect(described_class.new(01,'tom','s').class).to eq(User)
      end
      
      it "should initalize with correct attributes" do
        test_user = described_class.new(01,'tom','s')
        expect(test_user).to have_attributes(
            user_id: 01,
            first_name: "tom",
            last_name: "s"
        )
      end   

      it "should check for method bookings" do
        test_user = described_class.new(01,'tom','s')

        expect(test_user).to respond_to :bookings
      end 

      it "should check for method all_accommodation" do
        test_user = described_class.new(01,'tom','s')

        expect(test_user).to respond_to :all_accommodation
      end 


      it "should check for method approve_booking" do
        test_user = described_class.new(01,'tom','s')

        expect(test_user).to respond_to :approve_booking
      end 
    
    end 
end       