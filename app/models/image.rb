class Image < ApplicationRecord
  belongs_to :destination
  has_one_attached :image_file

  def url_or_file_present
    if image_url.blank? && !image_file.attached?
      errors.add(:base, "Please provide either a URL or upload an image file.")
    end
  end 


end
