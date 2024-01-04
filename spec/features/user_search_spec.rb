require 'rails_helper'

RSpec.feature 'UserSearches', type: :feature do
  describe 'User search' do
    before :each do
      @user = create(:user)
      sign_in(@user)

      @user1 = create(:user, country: 'Portugal', city: 'Lisbon')
      @user2 = create(:user, country: 'Nepal', city: 'Kathmandu')
      @user3 = create(:user, country: 'Poland', city: 'London')
      @user4 = create(:user, country: 'Morrocco', city: 'Condon')
      sleep 1
    end

    describe 'Search by country' do
      it 'should be able to search user by country name' do
        visit root_path
        fill_in 'q_city_or_country_cont', with: 'Portugal'
        click_button 'Search'
        expect(page).to have_text(@user1.name)
        expect(page).to have_text(@user1.profile_title)
        expect(page).to have_text(@user1.country)
        expect(page).not_to have_text(@user2.country)
        expect(page).not_to have_text(@user4.country)
      end
      it 'should be able to search user by partial country name' do
        visit root_path
        fill_in 'q_city_or_country_cont', with: 'Po'
        click_button 'Search'
        expect(page).to have_text(@user3.name)
        expect(page).to have_text(@user3.profile_title)
        expect(page).to have_text(@user1.country)
        expect(page).to have_text(@user3.country)
        expect(page).not_to have_text(@user2.country)
      end
      it 'should be able to search user by any random character of country name' do
        visit root_path
        fill_in 'q_city_or_country_cont', with: 'l'
        click_button 'Search'
        expect(page).to have_text(@user2.name)
        expect(page).to have_text(@user2.profile_title)
        expect(page).to have_text(@user1.country)
        expect(page).to have_text(@user2.country)
        expect(page).to have_text(@user3.country)
        expect(page).not_to have_text(@user4.country)
      end
    end
    describe 'View user profile' do
      it 'should visit user profile' do
        visit root_path
        fill_in 'q_city_or_country_cont', with: 'Portugal'
        click_button 'Search'
        expect(page).to have_text(@user1.name)
        expect(page).to have_text(@user1.profile_title)
        expect(page).to have_text(@user1.country)
        click_link 'View Profile'
        expect(page).to have_current_path("/members/#{@user1.id}")
        sleep 2
        expect(page).to have_text(@user1.name)
        expect(page).to have_text(@user1.profile_title)
        expect(page).to have_text(@user1.address)
        expect(page).to have_text('About')
        expect(page).to have_text(@user1.bio)
      end
    end
  end
end
