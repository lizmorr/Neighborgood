require "rails_helper"

feature "user edits neighborhood", %(
  As the original poster
  I want to be able to update a neighborhood's information
  So I can correct errors or provide new information.
) do

  before do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    neighborhood = FactoryGirl.create(:neighborhood, user_id: user.id)
    visit edit_neighborhood_path(neighborhood)
  end

  scenario "user successfully edits neighborhood" do
    fill_in "Name", with: "Uptown"
    select("West", from: "Location")
    fill_in "Description", with: "Super!"
    click_on "Submit"

    expect(page).to have_content("Uptown")
    expect(page).to have_content("West")
    expect(page).to have_content("Super!")
  end

  scenario "user unsuccessfully edits neighborhood" do
    fill_in "Name", with: "Hi"
    fill_in "Description", with: "!"
    click_on "Submit"

    expect(page).to have_content("Name is too short (minimum is 4 characters)")
    expect(page).to have_content("Description is too short")
  end
end
