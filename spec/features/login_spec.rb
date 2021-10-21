
feature 'login' do
  it 'should login a user who has an account' do
    register_user
    visit '/login'
    expect(page).to have_content('MakersBNB')
    expect(page).to have_field('first-name')
    expect(page).to have_field('last-name')
    fill_in "first-name", with: 'John'
    fill_in "last-name", with: 'Smith'
    click_button "Log in"
  end

  it 'should not login a user who does not have an account' do
    visit '/login'
  
    fill_in "first-name", with: 'John'
    fill_in "last-name", with: 'Smith'
    click_button "Log in"
    
    expect(page).to have_current_path("/login")
    # add a check here for a flash
  end

  it 'should have a button on the page that takes you to the register page' do
    visit '/login'
    click_button "Register for an account"
    expect(page).to have_current_path("/register")
  end
end
