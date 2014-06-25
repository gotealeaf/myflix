Myflix::Application.routes.draw do

  root to: 'pages#front'

  get '/register', to: 'users#new'

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get '/sign_in', to: 'sessions#new'
  
  get '/sign_out', to: 'sessions#destroy'
  get '/my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'
  get '/people', to: 'relationships#index'
  resources :videos, only: [:show] do
    
    resources :reviews, only: [:create]
    collection do 
      get 'search', to: 'videos#search'
    end
  end
  resources :categories, only: [:show]
  resources :users, except: [:destroy, :new] 
  resources :sessions, only: [:create]
  resources :queue_items, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]

  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to:'forgot_passwords#confirm'
  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'
end
