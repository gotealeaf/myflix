Myflix::Application.routes.draw do
  
  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'videos#index'
  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'
  get '/following', to: 'users#following'

  resources :videos, only: [:show, :index] do
    collection do
      get :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  
  resources :users, only: [:create, :edit, :show]  do
    member do
      post 'follow'
      post 'unfollow'
    end
  end
  resources :categories, only: [:show]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:create, :destroy]
  
  resources :forgot_passwords, only: [:create]
  get 'forgot_password', to: 'forgot_passwords#new'
  get 'confirm_password_reset', to: 'forgot_passwords#confirm'
  
  resources :password_resets, only: [:show, :create]
  get 'invalid_token', to: 'pages#invalid_token'
  
  resources :invitations, only: [:create, :show]
  get 'invite', to: 'invitations#new'
end
