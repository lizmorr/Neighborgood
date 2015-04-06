require "rails_helper"

feature "admin can delete new neighborhood", %(
  As an admin
  I want to delete a neighborhood
  So that no one can review it.
) do

  scenario "admin successfully deletes a neighborhood" do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    neighborhood = FactoryGirl.create(:neighborhood)
    visit admin_neighborhoods_path

    click_on "Delete this Neighborhood"
    expect(page).to have_content("Neighborhood has been deleted")
    expect(page).to_not have_content(neighborhood.name)
  end

  scenario "non-admin user attempts to delete a neighborhood" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    neighborhood = FactoryGirl.create(:neighborhood)
    visit neighborhood_path(neighborhood)

    expect(page).to_not have_content("Delete this Neighborhood")
  end
end
