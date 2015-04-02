class Vote < ActiveRecord::Base
  belongs_to :review, counter_cache: true
  belongs_to :user

  validates :user, presence: true
  validates :review, presence: true
  validates :value, numericality: { in: -1..1 }
  validates_uniqueness_of :user_id, scope: :review_id
end
