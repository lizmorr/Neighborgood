require "rails_helper"

feature "user edits review", %(
  As the original reviewer
  I want to be able to update a review of a neighborhood
  So I can correct errors and provide new information.
) do

  scenario "original reviewer successfully edits review" do
    user = FactoryGirl.create(:user)
    neighborhood = FactoryGirl.create(:neighborhood)
    review = FactoryGirl.create(:review, user: user, neighborhood: neighborhood)

    sign_in_as(user)

    visit neighborhood_path(neighborhood)

    click_on "Edit Review"

    choose "2"
    fill_in "Review", with: "This neighborhood is not what I remember."
    click_on "Edit Review"

    within("\#review_#{review.id} .rating") do
      expect(page).to have_content("2")
      expect(page).to_not have_content(review.rating)
    end
    within("\#review_#{review.id}") do
      expect(page).to have_content("This neighborhood is not what I remember.")
      expect(page).to_not have_content(review.description)
    end
  end

  scenario "original reviwer unsuccessfully edits review" do
    user = FactoryGirl.create(:user)
    neighborhood = FactoryGirl.create(:neighborhood)
    FactoryGirl.create(:review, user: user, neighborhood: neighborhood)

    sign_in_as(user)

    visit neighborhood_path(neighborhood)

    click_on "Edit Review"

    choose "2"
    fill_in "Review", with: ""
    click_on "Edit Review"

    expect(page).to have_content("Description can't be blank")
  end

  scenario "non-original reviwer cannot see edit review link" do
    original_user = FactoryGirl.create(:user)
    random_user = FactoryGirl.create(:user)
    neighborhood = FactoryGirl.create(:neighborhood)
    FactoryGirl.create(
      :review, user: original_user, neighborhood: neighborhood
    )

    sign_in_as(random_user)

    visit neighborhood_path(neighborhood)

    expect(page).to_not have_content("Edit Review")
  end
end
