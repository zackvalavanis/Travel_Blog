class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, uniqueness: true
  has_many :likes
  has_many :destinations, through: :likes
  has_one_attached :profile_image

  def profile_image_url
    Rails.application.routes.url_helpers.url_for(profile_image) if profile_image.attached?
  end
  
end 