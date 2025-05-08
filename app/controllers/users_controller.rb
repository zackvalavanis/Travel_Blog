class UsersController < ApplicationController

  def index 
    @user = User.all
    render :index
  end 

  def create 
    @user = User.new(
      name: params[:name], 
      email: params[:email], 
      password: params[:password], 
      password_confirmation: params[:password_confirmation]
    ) 
    if @user.save 
        render json: { message: 'The user has been saved'}, status: :created
    else 
      render json: { errors: "The user couldn't be saved"}, status: :bad_request
    end 
  end 

end
