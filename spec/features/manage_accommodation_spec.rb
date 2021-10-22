# frozen_string_literal: true
require 'accommodation'

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

  scenario 'Visits manage accommodation page with an accommodation' do
    register_user
    login_user
    visit('/manage-accommodation')
    click_button "Add accommodation"
    fill_in('name', with: 'My Villa')
    fill_in('description', with: '4 bedroom villa')
    fill_in('price_per_night', with: '100')
    click_button "Submit"
    expect(page).to have_content("My Villa")
    expect(page).to have_content("4 bedroom villa")
    expect(page).to have_content("£100.00 per night")

  end
end
