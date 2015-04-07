require 'factory_girl'

FactoryGirl.define do
  factory :user do
    sequence(:email) {|n| "user#{n}@example.com" }
    password 'password'
    password_confirmation 'password'

    factory :admin_user do
      role 'admin'
    end
  end

  factory :neighborhood do
    sequence(:name) { |n| "Pretty#{n}" }
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

  factory :vote do
    user
    review
    value 1
  end
end
