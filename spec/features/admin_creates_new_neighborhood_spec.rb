require "rails_helper"

feature "admin can create new neighborhood", %(
  As an authenticated user
  I want to add a neighborhood to Boston
  So that others can tell me about it (review it).
) do

  scenario "admin successfully adds new neighborhood" do
    visit new_neighborhood_path
    fill_in "Name", with: "Downtown"
    select("East", from: "Location")
    fill_in "Description", with: "Lame."
    click_on "Submit"
  end

  scenario "admin adds invalid new neighborhood"
end
