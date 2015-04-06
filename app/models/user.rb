class User < ActiveRecord::Base
  has_many :neighborhoods
  has_many :reviews
  has_many :votes

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
