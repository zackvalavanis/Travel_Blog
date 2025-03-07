class DestinationsController < ApplicationController

  def index 
    render json: { message: 'Yo'}
  end 

  def show
    @destination = Destination.find_by(id: params[:id])
    render :show
  end 

  def create
    @destination = Destination.new( 
      country: params[:country],
      city: params[:city], 
      description: params[:description]
    )
    if @destination.save 
      render json: { message: 'Destination has been saved'}, status: :created
    else
      render json: {error: 'The destination cannot be created'}, status: :unprocessable_entity
    end 
  end 
  
  def update 
    @destination = Destination.find_by(id: params[:id])
    if @destination 
      @destination.update( 
      country: params[:country] || @destination.country, 
      city: params[:city] || @destination.city, 
      description: params[:description] || @destination.description   
    )
    render json: {message: 'the destination has been updated'}, status: :ok
    else 
      render json: {message: 'the destination could not be updated'}, status: :bad_request
    end 
  end 

  def destroy 
    @destination = Destination.find_by(id: params[:id])

    if @destination && @destination.delete 
      render json: {message: 'the destination has been deleted'}, status: :ok
    else 
      render json: {message: 'the destination could not be deleted'}, status: :bad_request
    end 
  end

end
