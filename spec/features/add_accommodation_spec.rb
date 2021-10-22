# frozen_string_literal: true

feature 'add accommodation' do
  scenario 'Should add new accommodation to the list of users accommodation' do
    visit '/add-accommodation'
    expect(page).to have_field("name")
    expect(page).to have_field("description")
    expect(page).to have_field("price_per_night")
    fill_in('name', with: 'My Villa')
    fill_in('description', with: '4 bedroom villa')
    fill_in('price_per_night', with: '100')
    click_button "Submit"
    expect(page).to have_content("Booking requests")
  end

  
end
