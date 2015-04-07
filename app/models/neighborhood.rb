class Neighborhood < ActiveRecord::Base
  belongs_to :user
  has_many :reviews
  mount_uploader :image, AvatarUploader

  LOCATIONS = %w(North Northeast East South Southwest Southeast West)

  validates :name, presence: true, uniqueness: true, length: { in: 4..30 }
  validates :location, presence: true, inclusion: { in: LOCATIONS }
  validates :description, length: { in: 2..40 }, allow_blank: true
  validates :user, presence: true

  def editable_by?(user)
    user == self.user
  end

  def destroyable_by?(user)
    user.admin?
  end

  def self.order_by_name(page)
    order(:name).page(page).per(10)
  end

  def self.search(search)
    if search
      where([ "name ILIKE ?", "%#{search}%"])
    else
      all
    end
  end
end
