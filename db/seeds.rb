# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: "Chicago" }, { name: "Copenhagen" }])
#   Mayor.create(name: "Emanuel", city: cities.first)
if Rails.env.development?
  User.find_or_create_by(email: "Test@Fake.com") do |user|
    user.username = "Master"
    user.password = "password123"
    user.role = "admin"
    # user.password_confirmation = "password123"
  end

  15.times do
    user = User.new(
      username: Faker::Name.name,
      email: Faker::Internet.email,
      password: Faker::Internet.password,
      sign_in_count: 0
    )
    if user.valid?
      user.save!
    end
  end

  20.times do
    neighborhood = Neighborhood.new(
      name: Faker::Address.city,
      location: %w(North Northeast East South Southwest Southeast West).sample,
      description: Faker::Lorem.paragraph(1, false),
      user_id: rand(2..User.all.count),
      created_at: Faker::Time.between(2.days.ago, Time.now),
      updated_at: Faker::Time.between(1.days.ago, Time.now)
    )
    if neighborhood.valid?
      neighborhood.save!
    end
  end

  5.times do
    review = Review.new(
      rating: rand(1..5),
      description: Faker::Lorem.sentence,
      user_id: rand(2..User.all.count),
      neighborhood_id: rand(1..Neighborhood.all.count),
      created_at: Faker::Time.between(2.days.ago, Time.now),
      updated_at: Faker::Time.between(1.days.ago, Time.now)
    )
    if review.valid?
      review.save!
    end
  end

  10.times do
    vote = Vote.new(
      user_id: rand(2..User.all.count),
      review_id: rand(1..Review.all.count),
      value: [-1, 0, 1].sample
    )
    if vote.valid?
      vote.save!
    end
  end
end
