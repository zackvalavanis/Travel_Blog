class ImagesController < ApplicationController
  def index 
    @images = Image.all
    render :index 
  end 

  def show 
    @image = Image.find_by(id: params[:id])
    render :show 
  end 

    def create
      # Permit the nested image parameters (destination_id and image_url)
      image_params = params.require(:image).permit(:destination_id, :image_url)
  
      image_url = image_params[:image_url]
      destination_id = image_params[:destination_id]
  
      # Validate that image_url is present
      if image_url.blank?
        render json: { error: 'Image URL cannot be empty' }, status: :bad_request and return
      end
  
      # Create the image
      @image = Image.new(
        image_url: image_url,
        destination_id: destination_id
      )
      
      if @image.save
        render json: { message: 'Image has been saved', destination_id: destination_id }, status: :created
      else
        render json: { error: 'Some images could not be created' }, status: :bad_request
      end
    end
  

  def update
    @image = Image.find_by(id: params[:id])
    if @image
      if @image.update( 
        image_url: params[:image_url] || @image.image_url, 
        destination_id: params[:destination_id] || @image.destination_id
      )
      render json: { message: 'Image updated successfully'}, status: :ok
      else 
        render json: { error: @image.errors.full_messages}, status: :unprocessable_entity
      end 
    else 
      render json: { error: 'Image not found'}, status: :not_found
    end 
  end 

  def destroy 
    @image = Image.find_by(id: params[:id])

    if @image 
      if @image.destroy 
        render json: { message: 'The image has been deleted'}, status: :ok
      else 
        render json: { error: @image.errors.full_messages}, status: :unprocessable_entity
      end 
    else 
      render json: { error: 'The image cannot be found'}, status: :not_found
    end 
  end
end
