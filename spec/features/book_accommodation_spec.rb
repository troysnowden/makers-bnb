feature 'book accommodation' do
    scenario 'Should be able to select a date' do
      visit '/book-accommodation'
      expect(page).to have_content('Please choose the date you would like to stay:')
    end

    scenario 'Should be able to select a max price' do
      visit '/book-accommodation'
      expect(page).to have_content('Please enter your max price:')
    end

    scenario 'Should be able to see an accom' do
      visit '/book-accommodation'
      expect(page).to have_content('Sunny Sands')
      expect(page).to have_content('coarse and rough')
      expect(page).to have_content('£80 per night')
      expect(page).to have_selector("input[type=submit][value='Book Sunny Sands']")
      expect(page).to have_selector("input[type=submit][id='submit-booking-1']")
    end
    
    scenario 'Should be able to see an accom, and book it' do
      visit '/book-accommodation'
      expect(page).to have_content('Sunny Sands')
      expect(page).to have_content('coarse and rough')
      expect(page).to have_content('£80 per night')
      expect(page).to have_selector("input[type=submit][value='Book Sunny Sands']")
      expect(page).to have_selector("input[type=submit][id='submit-booking-1']")
      click_button('Book Sunny Sands')

      expect(page).to have_current_path("/")
    end
end