require "rails_helper"

feature "user views all reviews for neighborhood", %(
  As a viewer
  I want to see all the reviews for a neighborhood
  So that I could learn more about that neighborhood.
) do

  scenario "viewer views reviews of neighborhood" do
    neighborhood = FactoryGirl.create(:neighborhood)
    review = FactoryGirl.create(:review, neighborhood: neighborhood)

    visit neighborhood_path(neighborhood)

    expect(page).to have_content(review.rating)
    expect(page).to have_content(review.description)
    expect(page).to have_content(review.user.email)
  end
end
