class Destination < ApplicationRecord
  has_many :images, dependent: :destroy 
end
