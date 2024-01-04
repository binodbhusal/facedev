require 'rails_helper'

RSpec.feature 'UserSettings', type: :feature do
  describe 'User Seetings' do
    before :each do
      @user = create(:user)
      sign_in(@user)
      sleep 1
    end
    it 'User able to update personal details' do
      visit "/members/#{@user.id}"
      expect(page).to have_text(@user.name)
      expect(page).to have_text(@user.profile_title)
      expect(page).to have_text(@user.address)
      find(:xpath, '//a[contains(@class, "edit-profile")]').click
      sleep 1
      expect(page).to have_content('Update Personal Details', wait: 5)
      fill_in 'user_first_name', with: 'Binod'
      fill_in 'user_last_name', with: 'Bhusal'
      fill_in 'user_city', with: 'Lisbon'
      fill_in 'user_country', with: 'Portugal'
      fill_in 'user_profile_title', with: 'SW Engineer'
      click_button 'Save Changes'
      sleep 3
      expect(page).to have_current_path("/members/#{@user.id}")

      expect(page).to have_text('Binod Bhusal')
      expect(page).to have_text('Lisbon, Portugal')
      expect(page).to have_text('SW Engineer')
    end
  end
end
