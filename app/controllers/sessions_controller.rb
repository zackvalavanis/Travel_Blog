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
      render json: { name: user.name, jwt: jwt, email: user.email, user_id: user.id, profile_image: user.profile_image.attached? ? url_for(user.profile_image) : nil}, status: :created
      else 
        render json: {}, status: :unauthorized
      end 
  end

  def google_auth 
    auth = request.env['omniauth.auth']
    user = User.find_or_initialize_by(provider: auth.provider, uid: auth.uid)
    user.name = auth.info.name
    user.email = auth.info.email
    user.password = SecureRandom.hex(15) if user.new_record?
    user.save!

    jwt = JWT.encode(
      {
        user_id: user.id, exp: 24.hours.from_now.to_i
      }, 
      Rails.application.credentials.fetch(:secret_key_base), 
      'HS256'
    )
    redirect_to "http://localhost:5173/oauth-success?jwt=#{jwt}&email=#{user.email}&user_id=#{user.id}"
  end
end
