require "rails_helper"

feature "admin can create new neighborhood", %(
  As an authenticated user
  I want to add a neighborhood to Boston
  So that others can tell me about it (review it).
) do

  before do
    user = FactoryGirl.create(:user)
    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password
    click_button "Log in"

    visit new_neighborhood_path
  end

  scenario "user successfully adds new neighborhood" do
    fill_in "Name", with: "Downtown"
    select("East", from: "Location")
    fill_in "Description", with: "Lame."
    click_on "Submit"

    expect(page).to have_content("Neighborhood Added!")
    expect(page).to have_content("Downtown")
    expect(page).to have_content("East")
  end

  scenario "user attempts to add invalid neighborhood" do
    click_on "Submit"

    expect(page).to have_content("Your neighborhood was not saved")
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Name is too short (minimum is 4 characters)")
  end
end
