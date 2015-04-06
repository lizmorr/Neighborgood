  class Vote < ActiveRecord::Base
  belongs_to :review
  belongs_to :user

  validates :user, presence: true
  validates :review, presence: true
  validates :value, numericality: { in: -1..1 }
  validates_uniqueness_of :user_id, scope: :review_id

  def self.build_upvote(user, review)
    new do |vote|
      vote.user = user
      vote.review = review
      vote.value = 1
    end
  end

  def self.build_downvote(user, review)
    new do |vote|
      vote.user = user
      vote.review = review
      vote.value = -1
    end
  end
end
