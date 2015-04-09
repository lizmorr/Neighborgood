class Review < ActiveRecord::Base
  RATING = [1, 2, 3, 4, 5]

  belongs_to :neighborhood
  belongs_to :user
  has_many :votes

  validates :rating, presence: true, inclusion: { in: RATING }
  validates :description, presence: true, length: { maximum: 20 }
  validates :user, presence: true
  validates :neighborhood, presence: true

  def editable_by?(user)
    user == self.user
  end

  def deletable_by?(user)
    user == self.user || user.try(:admin?)
  end

  def find_vote(user)
    votes.find_by(user: user)
  end

  def voted_on_by?(user)
    votes.find_by(user_id: user)
  end

  # def upvoted_by?(user)
  #   votes.find_by(user_id: user, value: 1)
  # end
  #
  # def downvoted_by?(user)
  #   votes.find_by(user_id: user, value: -1)
  # end

  def total_votes
    votes.sum(:value)
  end
end
