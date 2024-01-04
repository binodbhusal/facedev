require 'rails_helper'

RSpec.feature "WorkExperiences", type: :feature do
  describe 'Work Experience' do
    describe 'Current User' do
        before :each do
            @user = create(:user)
            sign_in(@user)
            sleep 1
        end
        it 'should open work experience form and display validation error if form is empty for submission' do
        visit "/members/#{@user.id}"
        expect(page).to have_text('Work Experiences')
        find('a[data-controller="bs-modal-form"] i.bi.bi-plus').click
        sleep 1 
        expect(page).to have_text('Add new work experience')
        click_button 'Save Changes'
        expect(page).to have_text('errors prohibited your work experience from being saved')
        expect(page).to have_text("Start date can't be blank")
        expect(page).to have_text("Company can't be blank")
        expect(page).to have_text("Job title can't be blank")
        expect(page).to have_text("Location can't be blank")
        expect(page).to have_text("Employment type can't be blank")
        expect(page).to have_text("Employment type is not a valid employment type")
        expect(page).to have_text("Location type can't be blank")
        expect(page).to have_text("Location type is not a valid location type")
        expect(page).to have_text("End date must be present if you are not selected currently working here")
       sleep 2
       
        
       
       
       
       
     
        end
    end
  end
end
