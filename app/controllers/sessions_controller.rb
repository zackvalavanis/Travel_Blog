class SessionsController < ApplicationController

  def create 
    user = User.find_by(email: params[:email])
      if user && user.authenticate(params[:password])
      jwt = JWT.encode(
        {
          user_id: user.id, 
          exp: 24.hours.from_now.to_i
        }, 
        Rails.application.credentials.fetch(:secret_key_base),
        "HS256"
      )
      render json: { jwt: jwt, email: user.email, user_id: user.id, profile_image: user.profile_image.attached? ? url_for(user.profile_image) : nil}, status: :created
      else 
        render json: {}, status: :unauthorized
      end 
  end
end
