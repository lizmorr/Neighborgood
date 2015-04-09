require 'rails_helper'

feature 'visitor views neighborgood homepage', %(
  As a viewer
  I want to view a list of neighborhoods in Boston
  So that I can pick a neighborhood to review
) do

  scenario 'visitor views homepage' do
    neighborhood = FactoryGirl.create(:neighborhood)

    visit root_path
    expect(page).to have_content(neighborhood.name)
    expect(page).to have_content(neighborhood.location.upcase)
  end

  scenario 'visitor sees 10 neighborhoods per page' do
    9.times do |n|
      FactoryGirl.create(:neighborhood, name: "Hip#{n}")
    end
    9.times do |n|
      FactoryGirl.create(:neighborhood, name: "Pretty#{n}")
    end

    visit root_path
    expect(page).to have_content("Hip")
    expect(page).to_not have_content("Pretty")

    click_link("2")
    expect(page).to have_content("Pretty")
    expect(page).to_not have_content("Hip")
  end

end
