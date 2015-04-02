class Neighborhood < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  LOCATIONS = %W(North Northeast East South Southwest Southeast West)

  validates :name, presence: true, uniqueness: true, length: { in: 4..30 }
  validates :location, presence: true, inclusion: { in: LOCATIONS }
  validates :description, length: { in: 2..40 }, allow_blank: true
  validates :user, presence: true
end
