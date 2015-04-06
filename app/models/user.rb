class User < ActiveRecord::Base
  has_many :neighborhoods
  has_many :reviews

  ROLES = %w(member admin)

  validates :role, presence: true, inclusion: { in: ROLES }

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  def self.admin?
    self.role == 'admin'
  end

  def self.set_admin
    self.role = 'admin'
  end
end
