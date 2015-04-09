class User < ActiveRecord::Base
  has_many :neighborhoods
  has_many :reviews
  has_many :votes
  mount_uploader :image, AvatarUploader

  ROLES = %w(member admin)

  validates :role, presence: true, inclusion: { in: ROLES }
  validates :name, presence: true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  ratyrate_rater

  def admin?
    role == 'admin'
  end

  def editable_by?(user)
    user.admin?
  end

  def destroyable_by?(user)
    user.admin?
  end
end
