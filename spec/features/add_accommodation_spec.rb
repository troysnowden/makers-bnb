feature 'add accommodation' do
    scenario 'Should be able to submit vaild accommodation' do
        visit '/add-accommodation'
        fill_in('name', with: 'My accommodation')
        fill_in('description', with: '2 bedroom cottage')
        fill_in('price_per_night', with: '50')
        click_button('Submit')
    end

end