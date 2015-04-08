require 'rails_helper'

feature 'admin has link to admin home', %Q{
  As a admin
  I want to see an admin home link
  So that I can access admin page
} do

  # Acceptance Criteria
  # * If I'm signed in as admin, I have link to admin home
  # * If a regular user signs in, they do not see this link

  scenario 'admin signs in' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    visit root_path

    expect(page).to have_content("Admin Home")
  end

  scenario 'user signs in' do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit root_path

    expect(page).to_not have_content("Admin Home")
  end
end
