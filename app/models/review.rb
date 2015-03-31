class Review < ActiveRecord::Base
  belongs_to :neighborhood
  belongs_to :user

  validates :rating, presence: true, inclusion: { in: 1..5 }
  validates :description, presence: true, length: { maximum: 20 }
  validates :user, presence: true
  validates :neighborhood, presence: true
end
