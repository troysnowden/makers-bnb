feature 'book accommodation' do
  before(:each) do
    connection = PG.connect(dbname: 'mbnb_test')
    user_id = connection.exec('INSERT INTO users(first_name,last_name) VALUES(\'John\',\'Smith\') RETURNING id;')[0]["id"]  
    connection.exec("INSERT INTO accommodations(owner_id,name, description, price_per_night) VALUES(#{user_id},\'Sunny Sands\',\'course and rough\',\'80.00\');")
    connection.exec("INSERT INTO accommodations(owner_id,name, description, price_per_night) VALUES(#{user_id},\'Coastal Chalet\',\'nice pillows\',\'40.00\');")  
    connection.exec("INSERT INTO accommodations(owner_id,name, description, price_per_night) VALUES(#{user_id},\'Riviera Retreat\',\'great apart from the smell\',\'99.00\');")
  end
    
    scenario 'Should be able to see an accom, and book it' do
      register_user
      login_user
      visit '/book-accommodation'
      expect(page).to have_content('Sunny Sands')
      expect(page).to have_content('course and rough')
      expect(page).to have_content('£80.00 per night')
      expect(page).to have_selector("input[type=submit][value='Book Sunny Sands']")

      click_button('Book Sunny Sands')

      expect(page).to have_current_path("/confirm-booking")

      expect(page).to have_content('Sunny Sands')
      expect(page).to have_content('course and rough')
      expect(page).to have_content('£80.00 per night')
      expect(page).to have_selector("input[type=submit][value='Confirm booking']")

      click_button('Confirm booking')
    end
end