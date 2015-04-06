require "rails_helper"

feature "user can delete reviews", %(
  As the original reviewer
  I want to delete a review
  So that no one can see it
) do

  scenario "original reviewer can successfully delete review" do
    neighborhood = FactoryGirl.create(:neighborhood)
    user = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review, user: user, neighborhood: neighborhood)
    FactoryGirl.create(:review, neighborhood: neighborhood, rating: 3, description: "Yo.")

    visit new_user_session_path
    sign_in_as(user)

    visit neighborhood_path(neighborhood)

    click_on "Delete Review"

    expect(page).to have_content("Review deleted")

    within(".review .rating") do
      expect(page).to_not have_content(review.rating)
    end
    within(".review") do
      expect(page).to_not have_content(review.description)
    end

    # expect(page).to_not have_css("\#review_#{review.id}", text: review.rating)
  end

  scenario "a difference user cannot delete review" do
    neighborhood = FactoryGirl.create(:neighborhood)
    user = FactoryGirl.create(:user)
    FactoryGirl.create(:review, user: user, neighborhood: neighborhood)
    different_user = FactoryGirl.create(:user)

    visit new_user_session_path
    sign_in_as(different_user)

    visit neighborhood_path(neighborhood)

    expect(page).to_not have_content("Delete Review")
  end

  scenario "admin can successfully delete review" do
    neighborhood = FactoryGirl.create(:neighborhood)
    user = FactoryGirl.create(:user, role: 'admin')
    review = FactoryGirl.create(:review, neighborhood: neighborhood)

    visit new_user_session_path
    sign_in_as(user)

    visit neighborhood_path(neighborhood)

    click_on "Delete Review"

    expect(page).to have_content("Review deleted")
    expect(page).to_not have_css("\#review_#{review.id}", text: review.rating)
    expect(page).to_not have_content(review.description)
  end
end
