feature 'book accommodation' do
    scenario 'Should be able to select a date' do
      visit '/book-accommodation'
      fill_in 'calendar', with: '2021-10-21'
      click_button('Search')
      expect(page).to have_content('date')
    end

    scenario 'Should be able to select a max price' do
      visit '/book-accommodation'
      expect(page).to have_content('Max price')
    end
end