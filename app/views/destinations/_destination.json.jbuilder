json.array! @destinations do |destination|
  json.id destination.id
  json.country destination.country
  json.city destination.city
  json.description destination.description
  json.images destination.images
end