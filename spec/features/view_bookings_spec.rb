feature 'Viewing my booking' do
    # scenario 'Should be able to see a list of bookings which need approval' do
    #   new_user = UserAccess.register('troy','snowdon')
    #   new_accommodation = Accommodation.create(new_user.user_id, "My Villa", "4 Bed", 100)
    #   new_booking = BookingAccess.create(new_user.user_id, new_accommodation.accommodation_id, 100, 2021-12-10)
    #   visit('/view-bookings')
    #   expect(page).to have_content('My Villa')
    #   expect(page).to have_content('4 Bed')
    #   expect(page).to have_content('100')
    #   expect(page).to have_content('2021-12-10')
    # end

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
