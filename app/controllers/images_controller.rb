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
    image_params = params.require(:image).permit(:destination_id, :image_url, :image_file)
    Rails.logger.debug("Permitted image params: #{image_params.inspect}")
  
    destination_id = image_params[:destination_id]
    image_url = image_params[:image_url]
    image_file = image_params[:image_file]
  
    if image_url.blank? && image_file.blank?
      render json: { error: 'Please provide either an image URL or upload a file.' }, status: :bad_request and return
    end
  
    @image = Image.new(destination_id: destination_id, image_url: image_url)
    @image.image_file.attach(image_file) if image_file.present?
  
    if @image.save
      render json: {
        message: 'Image has been saved',
        destination_id: @image.destination_id,
        image_url: @image.image_url.presence || url_for(@image.image_file)
      }, status: :created
    else
      render json: { error: @image.errors.full_messages }, status: :unprocessable_entity
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
