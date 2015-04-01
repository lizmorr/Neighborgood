class Review < ActiveRecord::Base
  RATING = [1, 2, 3, 4, 5]

  belongs_to :neighborhood
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: RATING }
  validates :description, presence: true, length: { maximum: 20 }
  validates :user, presence: true
  validates :neighborhood, presence: true
end
