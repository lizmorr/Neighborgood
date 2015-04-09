require "rails_helper"

feature "admin can change user's role", %{
  As a admin
  I want to see a list of users
  So that I can promote/demote them
} do

  scenario "admin promotes user" do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    user = FactoryGirl.create(:user)

    visit admin_neighborhoods_path

    within("\#user_#{user.id}") do
      click_on "Edit this User"
    end

    choose "Admin"
    click_on "Edit User"

    expect(page).to have_content("User updated!")
  end

  scenario "admin demotes user" do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    another_admin = FactoryGirl.create(:admin_user)

    visit admin_neighborhoods_path

    within("\#user_#{another_admin.id}") do
      click_on "Edit this User"
    end

    choose "Member"
    click_on "Edit User"

    expect(page).to have_content("User updated!")
  end

  scenario "user tries to edit self" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit edit_admin_user_path(user)
    expect(page).to have_content("You don't have access to this page!")
  end

end
