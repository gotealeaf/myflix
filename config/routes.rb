Myflix::Application.routes.draw do
  root to: 'pages#front'
  get '/home', to: 'videos#index', as: 'home'
  get 'ui(/:action)', controller: 'ui'

  resources :categories, only: [:show]
  
  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  
  resources :users, only: [:create, :show]
  get '/register', to: 'users#new', as: 'register'

  resources :relationships, only: [:create, :destroy]
  get '/people', to: 'relationships#index'

  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'
  get '/my_queue', to: 'queue_items#index'

  get '/sign_in', to: 'sessions#new', as: 'sign_in'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy', as: 'sign_out'

  
end
