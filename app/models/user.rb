class User < ActiveRecord::Base
  has_many :neighborhoods
  has_many :reviews

  def self.current
    Thread.current[:user]
  end

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
