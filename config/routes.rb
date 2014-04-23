Myflix::Application.routes.draw do
  root to: 'pages#front'
  
  resources :videos, only:[:show] do
    collection do
      get :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  namespace :admin do
    resources :videos, only: [:new, :create]
    resources :payments, only: [:index]
  end

  resources :categories, only: [:show], path: 'genre'
  resources :users, only: [:create, :show]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :forgot_passwords, only: [:create]
  resources :password_resets, only: [:show, :create]
  resources :invitations, only: [:new, :create]
  
  post 'update_queue', to: 'queue_items#update_queue'
  
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'videos#index'
  get 'show', to: 'videos#show'
  get 'register', to: 'users#new'
  get 'register/:token', to: 'users#new_with_invitation_token', as: 'register_with_token'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'my_queue', to: 'queue_items#index'
  get 'people', to: 'relationships#index'
  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  get 'expired_token', to: 'pages#expired_token'

  require 'sidekiq/web'
  mount Sidekiq::Web, at: '/sidekiq'
  mount StripeEvent::Engine => '/stripe_events'
end
