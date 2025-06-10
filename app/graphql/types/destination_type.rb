module Types 
  class DestinationType < Types::BaseObject
    field :id, ID, null: false
    field :city, String, null:false
    field :country, String, null:false
  end
end