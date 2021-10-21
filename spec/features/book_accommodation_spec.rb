feature 'book accommodation' do
    scenario 'Should be able to select a date' do
      visit '/book-accommodation'
      expect(page).to have_content('Please choose the date you would like to stay:')
    end

    scenario 'Should be able to select a max price' do
      visit '/book-accommodation'
      expect(page).to have_content('Please enter your max price:')
    end

    scenario 'Should be able to got to the "Manage my Accommodation" page' do
      visit '/book-accommodation'
      click_button 'Manage my accommodation'
      expect(page).to have_selector(:link_or_button, 'Add accommodation')
    end
    
end