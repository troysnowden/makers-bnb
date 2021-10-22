feature 'Viewing my booking' do
  scenario 'Should be able to see a list of bookings which need approval' do
    register_user
    login_user
    visit('/view-bookings')
    expect(page).to have_content('Bookings requested')
  end

  scenario 'Should be able to see a list of bookings which have been approvde' do
    register_user
    login_user
    visit('/view-bookings')
    expect(page).to have_content('Confirmed bookings')
  end
end