require "rails_helper"

feature "admin can create new neighborhood", %(
  As an authenticated user
  I want to add a neighborhood to Boston
  So that others can tell me about it (review it).
) do

  scenario "admin successfully adds new neighborhood" do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    visit admin_neighborhoods_path

    fill_in "Name", with: "Downtown"
    select("East", from: "Location")
    fill_in "Description", with: "Lame."
    click_on "Submit"

    expect(page).to have_content("Neighborhood Added!")
    expect(page).to have_content("Downtown")
    expect(page).to have_content("East")
  end

  scenario "admin attempts to add invalid neighborhood" do
    admin = FactoryGirl.create(:admin_user)
    sign_in_as(admin)

    visit admin_neighborhoods_path

    click_on "Submit"

    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Name is too short (minimum is 4 characters)")
  end

  scenario "user attempts to add neighborhood" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit admin_neighborhoods_path
    expect(page).to have_content("You don't have access to this page!")
  end

  scenario "visitor attempts to add neighborhood" do
    visit admin_neighborhoods_path
    expect(page).to have_content("You don't have access to this page!")
  end
end
