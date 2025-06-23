class UsersController < ApplicationController

  def index 
    @users = User.all
    render json: @users.as_json(only: [:id, :name, :email])
  end 

  def show
    @user = User.includes(likes: { destination: :images }).find_by(id: params[:id])
    render :show
  end

  def create 
    @user = User.new(
      name: params[:name], 
      email: params[:email], 
      password: params[:password], 
      password_confirmation: params[:password_confirmation],
    ) 

    if params[:profile_image].present?
      @user.profile_image.attach(params[:profile_image])
    end

    if @user.save 
        render json: { message: 'The user has been saved'}, status: :created
    else 
      render json: { errors: "The user couldn't be saved"}, status: :bad_request
    end 
  end 

  def destroy 
    @user = User.find_by(id: params[:id])

    if @user 
      @user.destroy
      render json: {message: 'User deleted'}
    else 
      render json: {message: 'the user doesnt exist'}
    end
  end

end
