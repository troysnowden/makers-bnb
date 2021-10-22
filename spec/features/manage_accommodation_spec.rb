# frozen_string_literal: true
require 'accommodation'

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

  scenario 'Visits manage accommodation page with an accommodation' do
    visit('/manage-accommodation')
    new_user = UserAccess.register('troy','snowdon')
    new_accommodation = Accommodation.create(new_user.user_id, "My Villa", "4 Bed", 100)
    expect(page).to have_content("My Villa")
    expect(page).to have_content("4 Bed")
    expect(page).to have_content("100")

  end
end
