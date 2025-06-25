class UsersController < ApplicationController

  def index 
    @users = User.all
    render json: @users.as_json(only: [:id, :name, :email])
  end 

  def show
    @user = User.includes(likes: { destination: :images }).find_by(id: params[:id])
  
    if @user.nil?
      render json: { error: "User not found" }, status: :not_found
      return
    end
  
    render json: {
      id: @user.id,
      name: @user.name,
      email: @user.email,
      profile_image_url: @user.profile_image.attached? ? url_for(@user.profile_image) : nil,
      background_image_url: @user.background_image.attached? ? url_for(@user.background_image) : nil,
      likes: @user.likes.map do |like|
        {
          id: like.id,
          destination: {
            id: like.destination.id,
            city: like.destination.city,
            country: like.destination.country,
            description: like.destination.description,
            image: like.destination.images.map { |img| url_for(img) }
          }
        }
      end
    }
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

    if params[:background_image].present?
      @user.background_image.attach(params[:background_image])
    end

    if @user.save 
        render json: { message: 'The user has been saved'}, status: :created
    else 
      render json: { errors: "The user couldn't be saved"}, status: :bad_request
    end 
  end 
  
  def update
    @user = User.find_by(id: params[:id])
  
    if @user.nil?
      render json: { message: "User not found" }, status: :not_found
      return
    end
  
    if params[:profile_image].present?
      @user.profile_image.purge if @user.profile_image.attached?
      @user.profile_image.attach(params[:profile_image])
    end

    if params[:background_image].present?
      @user.background_image.purge if @user.background_image.attached?
      @user.background_image.attach(params[:background_image])
    end
  
    if @user.save
      render json: { message: "Profile image updated successfully" }, status: :ok
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessable_entity
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
