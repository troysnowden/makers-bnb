# frozen_string_literal: true

feature 'Viewing manage accommodation page' do
  scenario 'visits manage accommodation page with no accommodations' do
    visit('/manage-accommodation')
    expect(page).to have_content('You have no accommodations listed')
  end

  scenario 'visits manage accommodation page with no requests ' do
    visit('/manage-accommodation')
    expect(page).to have_content('You have no booking requests')
  end

  scenario 'visits manage accommodation page with no confirmed bookings ' do
    visit('/manage-accommodation')
    expect(page).to have_content('You have no confirmed bookings')
  end
end
