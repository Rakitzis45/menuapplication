Rails.application.routes.draw do
  
  resources :items
  resources :categories do 
    resources :items 
  end
  resources :cuisines
  resources :reviews
  resources :restaurants do 
    get '/menu', to: 'restaurants#menu'
    resource :categories
  end
  resources :users do
    resources :restaurants
    get '/myrestaurants', to:'users#myrestaurants'
  end

  

  get '/search', to: 'static#search'
  root "static#search"

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/success', to: 'sessions#success'
  get 'auth/:provider/callback', to: 'sessions#googleAuth'

  get '/logout', to: 'sessions#destroy'



end
