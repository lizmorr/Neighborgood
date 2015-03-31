class Neighborhood < ActiveRecord::Base
  belongs_to :user
  LOCATIONS = %w(North Northeast East South Southwest Southeast West)

  validates :name, presence: true, uniqueness: true, length: { in: 4..30 }
  validates :location, presence: true, inclusion: { in: LOCATIONS }
  validates :description, length: { in: 2..20 }, allow_blank: true
  validates :image_url
  validates :user_id, presence: true
end
