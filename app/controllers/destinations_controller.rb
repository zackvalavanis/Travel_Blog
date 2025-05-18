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

    # if current_user 
      @destination = Destination.new( 
        country: params[:country],
        city: params[:city], 
        description: params[:description], 
        state: params[:state]
      )
      if @destination.save 
        render json: { message: 'Destination has been saved',
          destinationid: @destination.id
        }, status: :created

      else
        render json: {error: 'The destination cannot be created'}, status: :unprocessable_entity
      end 
    # end 
  end 
  
  def update 
    @destination = Destination.find_by(id: params[:id])
    if @destination 
      if @destination.update(
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
    @destination = Destination.find_by(id: params[:id])
  
    if @destination && @destination.destroy
      render json: { message: 'The destination has been deleted' }, status: :ok
    else 
      render json: { message: 'The destination could not be deleted' }, status: :bad_request
    end 
  end

end
