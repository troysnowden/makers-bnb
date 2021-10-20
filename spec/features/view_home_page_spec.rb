# frozen_string_literal: true

feature 'Viewing homepage' do
  scenario 'visits homepage' do
    visit('/')
    expect(page).to have_content('MakersBNB')
    expect(page).to have_content('Manage my accommodation')
  end
end
