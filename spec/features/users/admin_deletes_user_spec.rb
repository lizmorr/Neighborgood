require 'rails_helper'

feature 'admin can delete users', %{
  As a admin
  I want to see a list of users
  So that I can delete them
} do

  scenario 'admin deletes user' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    user = FactoryGirl.create(:user)

    visit admin_neighborhoods_path

    within("\#user_#{user.id}") do
      click_on "Delete this User"
    end

    expect(page).to have_content("User has been deleted")
    expect(page).to_not have_content(user.email)
  end

  scenario 'admin deletes self' do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    visit admin_neighborhoods_path

    click_on "Delete this User"

    expect(page).to have_content("You don't have access to this page!")
  end
end
