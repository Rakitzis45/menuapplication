Rails.application.routes.draw do
  
  resources :items
  resources :categories
  resources :cuisines
  resources :reviews
  resources :restaurants
  resources :users

  resource :sessions, only: [:new, :create, :destroy]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
