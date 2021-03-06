# frozen_string_literal: true

feature 'Viewing landing page' do

  scenario 'visits landing page when not logged in' do
    visit('/')
    expect(page).to have_content('MakersBNB')
    expect(page).to have_selector(:button, 'Register')
    expect(page).to have_selector(:button, 'Log in')
    expect(page.find('#maldives')['src']).to have_content 'maldives.jpeg'
    expect(page.find('#maldives')['alt']).to have_content 'A beach in the maldives'

    expect(page.find('#register-link')['href']).to have_content '/register'
    expect(page.find('#login-link')['href']).to have_content '/login'
  end

  scenario 'visits landing page when logged in' do
    register_user
    login_user
    visit('/')
    expect(page).to have_content('MakersBNB')
    expect(page).to have_selector(:button, 'Manage accommodation')
    expect(page).to have_selector(:button, 'Book accommodation')
    expect(page.find('#maldives')['src']).to have_content 'maldives.jpeg'
    expect(page.find('#maldives')['alt']).to have_content 'A beach in the maldives'

    expect(page.find('#manage-accom-link')['href']).to have_content '/manage-accommodation'
    expect(page.find('#book-accom-link')['href']).to have_content '/book-accommodation'
  end

end
