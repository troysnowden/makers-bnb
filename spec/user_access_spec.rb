require 'user_access'
describe UserAccess do 
    describe '#user_registration' do

        it 'should regiser user with first name and last name' do
            user_access = UserAccess.new

            expect(user_access.user_registartion('troy','snowdon').class).to eq (User)

        end   


    end 


end 