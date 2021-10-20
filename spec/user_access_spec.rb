require 'user_access'
describe UserAccess do 
    describe '#user_registration' do

        it 'should regiser user with first name and last name' do
            new_user = UserAccess.user_registartion('troy','snowdon')
            expect(new_user.class).to eq (User)
            expect(new_user.first_name).to eq "troy"
            expect(new_user.last_name).to eq "snowdon"
        end   


    end 


end 