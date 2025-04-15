json.id destination.id
json.country destination.country
json.city destination.city
json.description destination.description
json.images destination.images
json.images destination.images.map { |image| 
  {
    id: image.id,
    image_url: image.image_url,
    destination_id: image.destination_id
  }
}

