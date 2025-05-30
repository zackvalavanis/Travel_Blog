Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get '/destinations' => 'destinations#index'
  get '/destinations/:id' => 'destinations#show'
  patch '/destinations/:id' => 'destinations#update'
  post '/destinations' => 'destinations#create'
  delete '/destinations/:id' => 'destinations#destroy'

  get '/images' => 'images#index'
  get '/images/:id' => 'images#show'
  patch '/images/:id' => 'images#update'
  post '/images' => 'images#create'
  delete '/images/:id' => 'images#destroy'

  get '/users' => 'users#index'
  post '/users' => 'users#create'

  post '/sessions' => 'sessions#create'

  # Defines the root path route ("/")
  # root "posts#index"
end
