class UsersController < ApplicationController

  def index 
    @users = User.all
    render :index
  end 

  def show 
    @user = User.find_by(id: params[:id])

    render :show
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
