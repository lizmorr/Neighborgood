class User < ActiveRecord::Base
  has_many :neighborhoods
  has_many :reviews

  ROLES = %w(member admin)

  validates :role, presence: true, inclusion: { in: ROLES }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def admin?
    .role == 'admin'
  end

  def set_admin
    .role = 'admin'
  end
end
