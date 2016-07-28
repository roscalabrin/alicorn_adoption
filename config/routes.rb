Rails.application.routes.draw do

  root to: "creatures#index"

  resources :creatures, only: [:index, :show]
  resources :types, only: [:show]  
  resources :carts, only: [:create]
  resources :users, only: [:new, :create, :show]
  
  post "/login", to: "sessions#create"
  get "/login", to: "sessions#new"
  delete "/logout", to: "sessions#destroy"
  
  put "/cart", to: "carts#update"
  delete "/cart", to: "carts#destroy"
  get "/cart", to: "carts#index"
  get "/:name", to: "types#show"
  get "*path" => redirect('/')
end