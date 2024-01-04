require 'rails_helper'

RSpec.feature 'HomePages', type: :feature do
  describe 'Root page' do
    it 'should show the home index page' do
      visit root_path
      expect(page).to have_text('Welcome to FaceDev')
      expect(page).to have_text('Find developers across the world')
      expect(page).to have_link('Sign in')
      expect(page).to have_button('Search')
      expect(page).to_not have_text('Find engineers across the world')
    end
  end
end
