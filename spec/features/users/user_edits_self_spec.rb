require "rails_helper"

feature "user edits self", %(
  As a user
  I want to be able to update my information
  So I can correct errors or provide new information.
) do

  scenario "user successfully edits self" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit edit_user_registration_path

    fill_in 'Current password', with: user.password
    attach_file("user_image",
      "#{Rails.root}/spec/fixtures/Stonehenge.jpg")
    click_button 'Update'

    expect(page).to have_content("Your account has been updated successfully.")
    expect(page).to have_css("img[src*='Stonehenge.jpg']")
  end

  scenario "user unsuccessfully edits self" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    visit edit_user_registration_path

    fill_in 'Email', with: "A@B"
    fill_in 'Password', with: "1"
    click_button 'Update'

    expect(page).to have_content("4 errors prohibited this user from being saved:")
    expect(page).to have_content("Email is invalid")
    expect(page).to have_content("Password confirmation doesn't match Password")
    expect(page).to have_content("Current password can't be blank")
    expect(page).to have_content("Current password can't be blank")
  end
end
