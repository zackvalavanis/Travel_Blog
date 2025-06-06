json.id like.id
json.user do 
  json.id like.user.id
  json.name like.user.name
  json.email like.user.email 
end 

json.destination do 
  json.id like.destination.id
  json.city like.destination.city
  json.country like.destination.country 
  json.description like.destination.description
  json.images like.destination.images.map { |image| 
  {
    id: image.id,
    image_url: image.image_url,
    destination_id: image.destination_id
  }
}
end
