class ImagesController < ApplicationController
  def index 
    render json: { message: 'hello'}
  end 
end
