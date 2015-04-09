require 'rails_helper'

feature "user can upvote a review", %(

) do

  scenario "user upvotes successfully" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    review = FactoryGirl.create(:review, user: user)

    visit neighborhood_path(review.neighborhood)

    first('.rating .inline-list#vote_links').find('.vote_icon #u_icon a').click

    expect(page).to have_content("Success!")
    expect(page).to have_content("Votes: 1")
    expect(page).to_not have_content("Upvote")
  end

  scenario "user downvotes successfully" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    review = FactoryGirl.create(:review, user: user)

    visit neighborhood_path(review.neighborhood)

    first('.rating .inline-list#vote_links').find('.vote_icon #d_icon a').click

    expect(page).to have_content("Success!")
    expect(page).to have_content("Votes: -1")
    expect(page).to_not have_content("Downvote")
  end

  scenario "user visits review that was already downvoted" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    review = FactoryGirl.create(:review, user: user)

    number = review.total_votes

    visit neighborhood_path(review.neighborhood)

    expect(page).to have_content("Votes: #{number}")

    first('.rating .inline-list#vote_links').find('.vote_icon #d_icon a').click

    visit neighborhood_path(review.neighborhood)

    expect(page).to have_content("Already voted. Cancel.")
    expect(page).to have_content("Votes: #{number - 1}")
  end

  scenario "user visits review that was already upvoted" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    review = FactoryGirl.create(:review, user: user)

    number = review.total_votes

    visit neighborhood_path(review.neighborhood)

    expect(page).to have_content("Votes: #{number}")

    first('.rating .inline-list#vote_links').find('.vote_icon #u_icon a').click

    visit neighborhood_path(review.neighborhood)

    expect(page).to have_content("Already voted. Cancel.")
    expect(page).to have_content("Votes: #{number + 1}")
  end

  scenario "unauthenticated user does not have option to vote" do
    review = FactoryGirl.create(:review)

    visit neighborhood_path(review.neighborhood)

    expect(page).to_not have_content ("Upvote")
    expect(page).to_not have_content ("Downvote")
  end

  scenario "user changes upvote to downvote" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    review = FactoryGirl.create(:review)
    number = review.total_votes

    visit neighborhood_path(review.neighborhood)

    first('.rating .inline-list#vote_links').find('.vote_icon #u_icon a').click

    visit neighborhood_path(review.neighborhood)
    first('.rating .inline-list#vote_links .cancel').click_on "Cancel"

    first('.rating .inline-list#vote_links').find('.vote_icon #d_icon a').click

    expect(page).to have_content("Success!")
    expect(page).to have_content("Votes: #{number - 1}")
    expect(page).to have_content("Already voted. Cancel.")
  end

  scenario "user changes downvote to upvote" do
    user = FactoryGirl.create(:user)
    sign_in_as(user)

    review = FactoryGirl.create(:review)
    number = review.total_votes

    visit neighborhood_path(review.neighborhood)

    first('.rating .inline-list#vote_links').find('.vote_icon #d_icon a').click

    visit neighborhood_path(review.neighborhood)
    first('.rating .inline-list#vote_links .cancel').click_on "Cancel."

    first('.rating .inline-list#vote_links').find('.vote_icon #u_icon a').click

    expect(page).to have_content("Success!")
    expect(page).to have_content("Votes: #{number + 1}")
    expect(page).to have_content("Already voted. Cancel.")
  end
end
