class User < ActiveRecord::Base
  has_many :neighborhoods
  has_many :reviews

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
