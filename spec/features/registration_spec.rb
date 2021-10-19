# frozen_string_literal: true

feature 'registration' do
  it 'should have a page with a form' do
    visit '/register'
    expect(page).to have_content('MakersBNB')
    expect(page).to have_field('first-name')
    expect(page).to have_field('last-name')

    # click_button "Submit"
  end
end
