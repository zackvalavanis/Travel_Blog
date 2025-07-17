class Destination < ApplicationRecord
  has_many :images, dependent: :destroy 
  belongs_to :user
  has_many :likes, dependent: :destroy
end
