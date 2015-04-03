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

    visit new_user_session_path
    sign_in_as(user)

    visit neighborhood_path(neighborhood)

    click_on "Delete"

    expect(page).to have_content("Review deleted")
    expect(page).to_not have_css("\#id_#{review.id}", text: review.rating)
    expect(page).to_not have_content(review.description)
  end

  scenario "a difference user cannot delete review" do
    neighborhood = FactoryGirl.create(:neighborhood)
    user = FactoryGirl.create(:user)
    review = FactoryGirl.create(:review, user: user, neighborhood: neighborhood)
    different_user = FactoryGirl.create(:user)

    visit new_user_session_path
    sign_in_as(different_user)

    visit neighborhood_path(neighborhood)

    expect(page).to_not have_content("Delete")
  end
end
