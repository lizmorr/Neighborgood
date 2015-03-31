require 'rails_helper'

feature 'visitor views neighborgood homepage', %Q(
  As a viewer
  I want to view a list of neighborhoods in Boston
  So that I can pick a neighborhood to review
) do

  scenario 'visitor views homepage' do
    neighborhood = FactoryGirl.create(:neighborhood)

    visit root_path
    expect(page).to have_content(neighborhood.name)
    expect(page).to have_content(neighborhood.location)
  end

end
