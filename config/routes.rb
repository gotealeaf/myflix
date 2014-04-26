require 'sidekiq/web'
Myflix::Application.routes.draw do
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
    mount Sidekiq::Web => '/sidekiq'
  end
  
  root to: 'pages#front'
  
  get 'ui(/:action)', controller: 'ui'
  
  resources :videos, only: [:show] do
    collection do
      get '/search', to: 'videos#search'
    end

    resources :reviews, only: [:create]    
  end

  namespace :admin do
    resources :videos, only: [:new, :create]
  end

  get 'home', to: 'videos#index'

  resources :categories, only: [:show] 

  resources :users, only: [:create, :show]
  get 'register', to: 'users#new'
  get 'register/:token', to: "users#new_with_token", as: 'register_with_token'
  resources :relationships, only: [:create, :destroy]
  get 'people', to: 'relationships#index'

  resources :sessions, only: [:create]
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'

  resources :queue_items, only: [:create, :destroy]
  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'

  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  get 'password_reset/:id', to: 'forgot_passwords#show', as: 'password_reset'
  get 'expired_token', to: 'pages#expired_token'
  post 'reset_forgot_password', to: 'forgot_passwords#reset'

  resources :invitations, only: [:new, :create]


end
