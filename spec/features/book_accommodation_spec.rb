feature 'book accommodation' do
    scenario 'Should be able to select a date' do
      visit '/book-accommodation'
      fill_in 'calendar', with: 'date'
      click_button('Search')
    end
end