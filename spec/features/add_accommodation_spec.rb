# frozen_string_literal: true

feature 'add accommodation' do
  scenario 'Should add new accommodation to the list of users accommodation' do
    register_user
    login_user
    visit '/add-accommodation'
    expect(page).to have_field("name")
    expect(page).to have_field("description")
    expect(page).to have_field("price_per_night")
    fill_in('name', with: 'My Villa')
    fill_in('description', with: '4 bedroom villa')
    fill_in('price_per_night', with: '100')
    click_button "Submit"
    expect(page).to have_content("My Villa")
    expect(page).to have_content("4 bedroom villa")
    expect(page).to have_content("£100.00 per night")
  end

  
end
