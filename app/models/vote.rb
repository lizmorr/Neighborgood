class Vote < ActiveRecord::Base
  belongs_to :review
  belongs_to :user

  validates :user, presence: true
  validates :review, presence: true
  validates :value, numericality: { in: -1..1 }
  validates :user_id, uniqueness: { scope: :review_id }

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

  def update_vote(value)
    update_attributes(value: value)
  end
end
