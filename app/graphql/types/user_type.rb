module Types 
  class UserType < Types::BaseObject
  	field :id, ID, null:false
    field :name, String, null:false
    field :email, String, null:false
    # field :profile_image, String, null:true
    
    # def profile_image
    #   object.profile_image.attached? ? Rails.application.routes.url_helpers.url_for(object.profile_image) : nil
    # end
  end 
end 