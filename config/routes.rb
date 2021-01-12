Rails.application.routes.draw do
  
  resources :items
  resources :categories do 
    resources :items, except: [:index, :show]
  end
  #resources :cuisines
  resources :reviews, only: [:create, :destroy]
  resources :restaurants do 
    get '/menu', to: 'restaurants#menu'
    resource :categories, except: [:index, :show]
  
  end
  resources :users, except: [:show] do
    resources :restaurants
    get '/myrestaurants', to:'users#myrestaurants'
    get '/index', to: 'user_restaurants#index'
  end

  get '/search', to: 'static#search'
  root "static#search"

  get '/login', to: 'sessions#login'
  post '/login', to: 'sessions#create'
  get '/success', to: 'sessions#success'
  get 'auth/:provider/callback', to: 'sessions#googleAuth'

  get '/logout', to: 'sessions#destroy'



end
