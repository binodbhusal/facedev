require 'rails_helper'

RSpec.feature 'Logins', type: :feature do
  describe 'Login' do
    let(:user) { create(:user) }
    it 'should Login successfuly with email and password' do
      visit root_path
      click_link 'Sign in'
      fill_in 'user_email', with: user.email
      fill_in 'user_password', with: user.password
      click_button 'Log in'
      expect(page).to have_link('My Network')
      expect(page).to have_link('My profile')
      expect(page).to have_link('Sign Out')
      expect(page).to have_text(user.name)
      expect(page).not_to have_text('Find engineers across the world')
    end
  end
end
