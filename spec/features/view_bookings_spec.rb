feature 'Viewing my booking' do
    scenario 'Should be able to see a list of bookings which need approval' do
      visit('/view-bookings')
      expect(page).to have_content('Bookings requested')
    end

    scenario 'Should be able to see a list of bookings which have been approvde' do
        visit('/view-bookings')
        expect(page).to have_content('Confirmed bookings')
    end
  end