json.partial! "destinations/destination", destination: @destination
json.images @destination.images, partial: 'images/image', as: :image
