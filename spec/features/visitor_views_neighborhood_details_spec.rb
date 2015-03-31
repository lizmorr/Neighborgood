require 'rails_helper'

feature 'visitor views neighborgood details', %Q(
  As a viewer
  I want to view the details of a neighborhood
  So I can find out more about it.
) do

  scenario 'visitor views homepage' do
    neighborhood = FactoryGirl.create(:neighborhood)

    visit neighborhood_path(neighborhood)
    expect(page).to have_content(neighborhood.name)
    expect(page).to have_content(neighborhood.location)
    expect(page).to have_content(neighborhood.description)
  end

end
