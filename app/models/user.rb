class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_many :likes
  has_many :destinations, through: :likes
end 