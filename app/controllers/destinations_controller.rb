class DestinationsController < ApplicationController

  def index
    @destinations = Destination.all
    render :index
  end
  

  def show
    @destination = Destination.find_by(id: params[:id])
    if @destination
      render :show
    else
      render plain: "Destination not found", status: :not_found
    end
  end
  

  def create
    user = User.find_by(id: params[:user_id])
    if user.nil?
      render json: { error: "User not found" }, status: :unprocessable_entity
      return
    end
  
    @destination = Destination.new(
      user_id: params[:user_id],
      country: params[:country],
      city: params[:city],
      description: params[:description],
      state: params[:state]
    )
  
    if @destination.save
      # Create Like
      @like = Like.new(
        user_id: params[:user_id],
        destination_id: @destination.id
      )
      @like.save
  
      # Handle images param which might be JSON string or array of hashes
      images_params = []
      if params[:images].present?
        if params[:images].is_a?(String)
          begin
            images_params = JSON.parse(params[:images])
          rescue JSON::ParserError => e
            Rails.logger.error("Failed to parse images JSON: #{e.message}")
            images_params = []
          end
        elsif params[:images].is_a?(Array)
          images_params = params[:images]
        end
      end
  
      images_params.each do |image_param|
        image = Image.new(destination_id: @destination.id)
        # use string or symbol keys for safety
        image.image_url = image_param['image_url'] || image_param[:image_url] if image_param['image_url'].present? || image_param[:image_url].present?
        
        if image_param['image_file'].present? || image_param[:image_file].present?
          file = image_param['image_file'] || image_param[:image_file]
          image.image_file.attach(file)
        end
  
        unless image.save
          Rails.logger.error("Failed to save image: #{image.errors.full_messages.join(', ')}")
        end
      end
  
      render json: { message: 'Destination has been saved and liked' }, status: :created
    else
      render json: { error: 'The destination cannot be created' }, status: :unprocessable_entity
    end
  end
  
  
  
  def update 
    @destination = Destination.find_by(id: params[:id])
    if @destination && current_user
      if @destination.user_id != current_user.id
        render json: { error: 'You are not authorized to edit this'}, status: :unauthorized
      elsif @destination.update(
        country: params[:destination][:country] || @destination.country, 
        city: params[:destination][:city] || @destination.city, 
        description: params[:destination][:description] || @destination.description, 
        state: params[:destination][:state] || @destination.state
      )
        render json: @destination, status: :ok
      else
        render json: { errors: @destination.errors.full_messages }, status: :unprocessable_entity
      end
    else 
      render json: { message: 'the destination could not be updated' }, status: :bad_request
    end 
  end
  
  
  def destroy 
    unless current_user
      render json: { message: 'You need to be logged in to delete a destination' }, status: :unauthorized
      return
    end
  
    @destination = Destination.find_by(id: params[:id])
    if @destination.nil?
      render json: { message: 'Destination not found' }, status: :not_found
      return
    end
  
    if current_user.id == @destination.user_id
      @destination.likes.destroy_all
      @destination.destroy
      render json: { message: 'The destination has been deleted' }, status: :ok
    else
      render json: { message: 'You are not authorized to delete this destination' }, status: :forbidden
    end
  end
  
end
