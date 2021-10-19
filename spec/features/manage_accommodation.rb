feature 'Viewing manage accommodation page' do
    scenario 'visits manage accommodation page with no accommodations' do
      visit('/manage-accommodation')
      expect(page).to have_content('You have no accommodations listed')
    end
  end