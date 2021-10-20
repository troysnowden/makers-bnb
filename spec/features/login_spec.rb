
feature 'login' do
  it 'should have a page with a login form' do
    visit '/login'
    expect(page).to have_content('MakersBNB')
    expect(page).to have_field('first-name')
    expect(page).to have_field('last-name')
    fill_in "first-name", with: 'John'
    fill_in "last-name", with: 'Smith'
    click_button "Log in"

    expect(page).to have_current_path("/test-homepage")
  end

  it 'should have a page with a login form' do
    visit '/login'
    expect(page).to have_content('MakersBNB')
    expect(page).to have_field('first-name')
    expect(page).to have_field('last-name')
  
    click_button "Register for an account"
    
    expect(page).to have_current_path("/register")
  end
end
