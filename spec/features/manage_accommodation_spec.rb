# frozen_string_literal: true

feature 'Viewing manage accommodation page' do
  scenario 'visits manage accommodation page with no accommodations' do
    register_user
    login_user
    visit('/manage-accommodation')
    expect(page).to have_content('You have no accommodations listed')
  end

  scenario 'visits manage accommodation page with no requests ' do
    register_user
    login_user
    visit('/manage-accommodation')
    expect(page).to have_content('You have no booking requests')
  end

  scenario 'visits manage accommodation page with no confirmed bookings ' do
    register_user
    login_user
    visit('/manage-accommodation')
    expect(page).to have_content('You have no confirmed bookings')
  end
end
