module Types 
  class DestinationType < Types::BaseObject
    field :id, ID, null: false
    field :city, String, null:false
    field :country, String, null:false
    field :description, String, null:false
    field :image, [String], null:false

    def image
      object.images.map(&:image_url)
    end
  end
end