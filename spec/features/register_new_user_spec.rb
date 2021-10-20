feature 'Register new user' do
  scenario 'Fill in first name and last name fields' do
    visit '/register'
    expect(page).to have_content('MakersBNB')
    expect(page).to have_field('first-name')
    expect(page).to have_field('last-name')
    fill_in "first-name", with: 'John'
    fill_in "last-name", with: 'Smith'
    click_button "Register"

    expect(page).to have_selector(:button, 'Manage accommodation')
    expect(page).to have_selector(:button, 'Book accommodation')
    expect(page.find('#maldives')['src']).to have_content 'maldives.jpeg'
    expect(page.find('#maldives')['alt']).to have_content 'A beach in the maldives'

    expect(page.find('#manage-accom-link')['href']).to have_content '/manage-accommodation'
    expect(page.find('#book-accom-link')['href']).to have_content '/book-accommodation'
  end
end