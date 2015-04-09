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
      click_on "Promote this User"
    end

    expect(page).to have_content("User Promoted to Admin!")
  end

  scenario "admin demotes user" do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    another_admin = FactoryGirl.create(:admin_user)

    visit admin_neighborhoods_path

    within("\#user_#{another_admin.id}") do
      click_on "Demote this User"
    end

    expect(page).to have_content("User Demoted to Member!")
  end
end
