Rails.application.routes.draw do
  
  resources :items
  resources :categories
  resources :cuisines
  resources :reviews
  resources :restaurants
  resources :users do
    resources :restaurants
  end

  get '/search', to: 'static#search'
  root "static#search"

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/success', to: 'sessions#success'
  get 'auth/:provider/callback', to: 'sessions#googleAuth'

  get '/logout', to: 'sessions#destroy'


end
