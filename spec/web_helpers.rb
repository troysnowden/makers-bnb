def register_user
  visit '/register'
  fill_in "first-name", with: 'John'
  fill_in "last-name", with: 'Smith'
  click_button "Register"
end

def login_user
  visit '/login'
  fill_in "first-name", with: 'John'
  fill_in "last-name", with: 'Smith'
  click_button "Log in"
end