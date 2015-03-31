class User < ActiveRecord::Base
  has_many :neighborhoods
  
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
end
