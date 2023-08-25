Rails.application.routes.draw do
  devise_for :users
  root to: "castles#index"
  resources :castles do
    resources :bookings, only: %i[new create]
  end
  get '/mine', to: 'castles#mine'
  resources :bookings, only: %i[index show destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
