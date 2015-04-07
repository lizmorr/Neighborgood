class User < ActiveRecord::Base
  has_many :neighborhoods
  has_many :reviews
  has_many :votes
  mount_uploader :image, AvatarUploader

  ROLES = %w(member admin)

  validates :role, presence: true, inclusion: { in: ROLES }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    role == 'admin'
  end

  def set_admin
    self.role = 'admin'
  end
end
