feature 'book accommodation' do
    scenario 'Should be able to select a date' do
      visit '/book-accommodation'
      fill_in 'calendar', with: 'date'
      click_button('Search')
      expect(page).to have_content('date')
    end

    scenario 'Should be able to select a max price' do
      visit '/book-accommodation'
      fill_in 'calendar', with: 'date'
      fill_in 'max_price', with: '80'
      click_button('Search')
      expect(page).to have_content('80')
    end
end