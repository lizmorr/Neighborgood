require "rails_helper"

feature "user reviews a neighborhood", %(
  As an authenticated user
  I want to review a neighborhood in Boston
  So that I could review the neighborhoods I know.
) do

  scenario "authenticated user successfully reviews a neighborhood" do
    user = FactoryGirl.create(:user)
    neighborhood = FactoryGirl.create(:neighborhood)

    sign_in_as(user)

    visit neighborhood_path(neighborhood)

    select("5", from: "Rating")
    fill_in "Review", with: "This neighborhood is super pretty. <3."

    click_on "Add Review"

    expect(page).to have_content("Review added successfully.")
    expect(page).to have_content("5")
    expect(page).to have_content("This neighborhood is super pretty. <3.")
    expect(ActionMailer::Base.deliveries.count).to eq(1)
  end

  scenario "authenticated user submits no information and fails" do
    user = FactoryGirl.create(:user)
    neighborhood = FactoryGirl.create(:neighborhood)

    sign_in_as(user)

    visit neighborhood_path(neighborhood)

    click_on "Add Review"

    expect(page).to have_content("Rating can't be blank")
    expect(page).to have_content("Description can't be blank")
    expect(ActionMailer::Base.deliveries.count).to eq(0)
  end

  scenario "authenticated user submits invalid description and fails" do
    user = FactoryGirl.create(:user)
    neighborhood = FactoryGirl.create(:neighborhood)

    sign_in_as(user)

    visit neighborhood_path(neighborhood)

    select("5", from: "Rating")
    fill_in "Review", with: "x" * 220

    click_on "Add Review"

    expect(page).to have_content("Description is too long")
    expect(ActionMailer::Base.deliveries.count).to eq(0)
  end

  scenario "unauthenticated user is unable to review neighborhood" do
    neighborhood = FactoryGirl.create(:neighborhood)

    visit neighborhood_path(neighborhood)

    select("5", from: "Rating")
    fill_in "Review", with: "This neighborhood."

    click_on "Add Review"

    expect(page).to have_content("You need to sign in or sign up before\
     continuing.")
    expect(ActionMailer::Base.deliveries.count).to eq(0)
  end
end
