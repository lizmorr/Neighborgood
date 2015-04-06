require 'rails_helper'

feature "user can upvote a review", %(

) do

  scenario "user upvotes successfully" do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    neighborhood = FactoryGirl.create(:neighborhood)
    review = FactoryGirl.create(:review, neighborhood: neighborhood, user: user)

    visit neighborhood_path(neighborhood)

    first('.review').click_on "Upvote"

    expect(page).to have_content("Success!")
    expect(page).to have_content("Votes: 1")
    expect(page).to_not have_content("Upvote")
  end

  scenario "user downvotes successfully" do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    neighborhood = FactoryGirl.create(:neighborhood)
    review = FactoryGirl.create(:review, neighborhood: neighborhood, user: user)

    visit neighborhood_path(neighborhood)

    first('.review').click_on "Downvote"

    expect(page).to have_content("Success!")
    expect(page).to have_content("Votes: -1")
    expect(page).to_not have_content("Downvote")
  end

  scenario "user visits review that was already downvoted" do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    neighborhood = FactoryGirl.create(:neighborhood)
    review = FactoryGirl.create(:review, neighborhood: neighborhood, user: user)

    number = review.total_votes(@score)

    visit neighborhood_path(neighborhood)

    expect(page).to have_content("Votes: #{number}")

    first('.review').click_on "Downvote"

    visit neighborhood_path(neighborhood)

    expect(page).to have_content("Already voted. Cancel.")
    expect(page).to have_content("Votes: #{number - 1}")
  end

  scenario "user visits review that was already upvoted" do
    user = FactoryGirl.create(:user)

    visit new_user_session_path

    fill_in "Email", with: user.email
    fill_in "Password", with: user.password

    click_button "Log in"

    neighborhood = FactoryGirl.create(:neighborhood)
    review = FactoryGirl.create(:review, neighborhood: neighborhood, user: user)

    number = review.total_votes(@score)

    visit neighborhood_path(neighborhood)

    expect(page).to have_content("Votes: #{number}")

    first('.review').click_on "Upvote"

    visit neighborhood_path(neighborhood)

    expect(page).to have_content("Already voted. Cancel.")
    expect(page).to have_content("Votes: #{number + 1}")
  end
  scenario "user cancels existing vote"
  scenario "user downvotes a review they previously upvoted successfully" #do
  #   user = FactoryGirl.create(:user)
  #
  #   visit new_user_session_path
  #
  #   fill_in "Email", with: user.email
  #   fill_in "Password", with: user.password
  #
  #   click_button "Log in"
  #
  #   neighborhood = FactoryGirl.create(:neighborhood)
  #   review = FactoryGirl.create(:review, neighborhood: neighborhood, user: user)
  #
  #   visit neighborhood_path(neighborhood)
  #
  #   first('.review').click_on "Upvote"
  #
  #   expect(page).to have_content("Success!")
  #   expect(page).to have_content("Votes: 1")
  #   expect(page).to have_content("Downvote")
  #   expect(page).to_not have_content("Upvote")
  #
  #   first('.review').click_on "Downvote"
  #
  #   expect(page).to have_content("Success!")
  #   expect(page).to have_content("Votes: -1")
  #   expect(page).to_not have_content("Downvote")
  #   expect(page).to have_content("Upvote")
  # end
end
