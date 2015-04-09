require 'rails_helper'

feature 'user can search by neighborhood' do

  scenario 'visitor searches for a neighborhood successfully' do
    FactoryGirl.create(:neighborhood, name: "One Neighborhood")
    FactoryGirl.create(:neighborhood, name: "Two Neighborhood")

    visit neighborhoods_path

    fill_in 'Search Neighborhoods', with: "one"
    click_button "Search"

    expect(page).to have_content("One Neighborhood")
    expect(page).to_not have_content("Two Neighborhood")
  end

  scenario 'visitor searches for something that does not exist' do
    FactoryGirl.create(:neighborhood, name: "One Neighborhood")
    FactoryGirl.create(:neighborhood, name: "Two Neighborhood")

    visit neighborhoods_path

    fill_in 'Search Neighborhoods', with: "Three"
    click_button "Search"

    expect(page).to have_content("One Neighborhood")
    expect(page).to have_content("Two Neighborhood")
    expect(page).to have_content("Search returned no results.")
  end
end
