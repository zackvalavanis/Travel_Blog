require 'omniauth'
require 'omniauth-google-oauth2'


Rails.application.config.middleware.use OmniAuth::Builder do 
  provider :google_oauth2, 
    ENV['GOOGLE_CLIENT_ID'], 
    ENV['GOOGLE_CLIENT_SECRET'], 
    { 
      scope: 'userinfo.email,userinfo.profile', 
      prompt: 'select_account', 
      access_type: 'offline'
    }
end

OmniAuth.config.allowed_request_methods = [:get]
OmniAuth.config.silence_get_warning = true

