require 'rails_helper'

feature 'user can search by neighborhood' do

  scenario 'visitor searches for a neighborhood successfully' do
    neighborhood_1 = FactoryGirl.create(:neighborhood, name: "One Neighborhood")
    neighborhood_2 = FactoryGirl.create(:neighborhood, name: "Two Neighborhood")

    visit neighborhoods_path

    fill_in 'Search Neighborhoods', with: "one"
    click_on "Search"

    expect(page).to have_content("One Neighborhood")
    expect(page).to_not have_content("Two Neighborhood")
  end

  scenario 'visitor searches for something that does not exist'
end
