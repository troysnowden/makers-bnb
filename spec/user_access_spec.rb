require 'user_access'
describe UserAccess do 
    describe '#user_registration' do

        it 'should regiser user with first name and last name' do
            new_user = UserAccess.register('troy','snowdon')
            expect(new_user.class).to eq (User)
            expect(new_user.first_name).to eq "troy"
            expect(new_user.last_name).to eq "snowdon"
        end   

    end 

    describe '#login' do

        it 'should log in if user has already registered with first name and last name' do
            new_user = UserAccess.register('troy','snowdon')
            registered_user = UserAccess.login('troy', 'snowdon')
            expect(registered_user.class).to eq (User)
            expect(registered_user.first_name).to eq "troy"
            expect(registered_user.last_name).to eq "snowdon"
        end   

        it 'should raise an error when users are not registered when trying to log in' do
            registered_user = UserAccess.login('troy', 'snowdon')
            expect(registered_user).to eq nil
          
        end   

    end 


end 