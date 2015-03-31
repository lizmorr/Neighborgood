require "rails_helper"

feature "user reviews a neighborhood", %(
  As an authenticated user
  I want to review a neighborhood in Boston
  So that I could review the neighborhoods I know.
) do

  scenario "authenticated user successfully reviews a neighborhood" do
    user = FactoryGirl.create(:user)
    neighborhood = FactoryGirl.create(:neighborhood)

    click_on "Sign In"

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_on "Log in"

    visit neighborhood_path(neighborhood)

    choose "5"
    fill_in "Review", with: "This neighborhood is amazing."

    click_on "Add Review"

    expect(page).to have_content("Review added successfully")
    expect(page).to have_content("5")
    expect(page).to have_content("This neighborhood is amazing.")
  end
end
