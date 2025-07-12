Rails.application.routes.draw do
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
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
  get '/users/:id' => 'users#show'
  delete '/users/:id' => 'users#destroy'
  post '/users' => 'users#create'
  patch '/users/:id' => 'users#update'

  post '/sessions' => 'sessions#create'

  get '/auth/:provider/callback', to: 'sessions#google_auth'
  get '/auth/failure', to: redirect('/')
  
  get '/likes' => 'likes#index'
  get '/likes' => 'likes#show'
  post '/likes' => 'likes#create'
  delete '/likes/:id' => 'likes#destroy'


  # Defines the root path route ("/")
  # root "posts#index"
end
