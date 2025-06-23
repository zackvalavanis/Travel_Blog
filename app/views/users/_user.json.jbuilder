json.id user.id
json.name user.name
json.email user.email
json.profile_image @user.profile_image.attached? ? url_for(@user.profile_image) : nil
json.likes user.likes do |like| 
  json.id like.id  
end
json.destinations user.destinations do |destination|
  json.id destination.id
  json.city destination.city
end
