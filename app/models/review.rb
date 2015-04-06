class Review < ActiveRecord::Base
  RATING = [1, 2, 3, 4, 5]

  belongs_to :neighborhood
  belongs_to :user

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
end
