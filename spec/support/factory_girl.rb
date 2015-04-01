require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'
  end

  factory :neighborhood do
    sequence(:name) { |n| "Neighborhood #{n}" }
    location "North"
    description "The best neighborhood."
    user
  end

  factory :review do
    rating 5
    description "This is awesome!"
    user
    neighborhood
  end

end
