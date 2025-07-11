class LikesController < ApplicationController
  
  def index 
    @likes = Like.all
    render :index
  end
  def show
    @likes = Like.where(user_id: params[:user_id])
    render :show
  end
  
  def create 
    @like = Like.new(
      user_id: params[:user_id], 
      destination_id: params[:destination_id]
    ) 
    if @like.save 
      render json: { message: 'Destination Liked!'}, status: :created
    else 
      render json: { errors: @like.errors.full_messages}, status: :unprocessable_entity
    end 
  end

  def destroy 
    @like = Like.find_by(id: params[:id])
    
    if @like 
      @like.destroy 
      render json: { message: 'Destination Unliked'}, status: :ok
    else 
      render json: { message: 'Like not Found'}, status: :not_found
    end
  end
end
