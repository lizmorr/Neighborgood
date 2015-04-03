class Review < ActiveRecord::Base
  RATING = [1, 2, 3, 4, 5]

  belongs_to :neighborhood
  belongs_to :user
  has_many :votes

  validates :rating, presence: true, inclusion: { in: RATING }
  validates :description, presence: true, length: { maximum: 20 }
  validates :user, presence: true
  validates :neighborhood, presence: true

  def voted_on_by?(user)
    votes.find_by(user_id: user_id)
  end

  def self.sum(score)

  end
end
