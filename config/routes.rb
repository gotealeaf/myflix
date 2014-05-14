require 'sidekiq/web'

Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'videos#index'
  get 'register', to: 'users#new'
  get 'register/:token', to: 'users#new_with_invitation_token', as: 'register_with_token'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'
  get 'people', to: 'relationships#index'
  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: "forgot_passwords#confirm"
  get 'expired_token', to: 'pages#expired_token'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  resources :categories, only: [:show]
  resources :users, only: [:create, :show]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :forgot_passwords, only: [:create]
  resources :password_resets, only: [:create, :show]
  resources :invitations, only: [:new, :create]

  namespace :admin do
    resources :videos, only: [:new, :create]    
  end

  mount Sidekiq::Web => '/sidekiq'
end
