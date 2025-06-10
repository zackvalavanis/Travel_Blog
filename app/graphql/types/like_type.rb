module Types 
  class LikeType < Types::BaseObject
    field :id, ID, null: false
    field :user, Types::UserType, null: false
    field :destination, Types::DestinationType, null: false
  end
end