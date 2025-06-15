json.id user.id
json.name user.name
json.email user.email
json.likes user.likes do |like| 
  json.id like.id
  json.destination like.destination
end
