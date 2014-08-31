require 'sidekiq/web'

Myflix::Application.routes.draw do
  root to: 'pages#front'
  resources :videos do
    get :search, to: 'videos#search', on: :collection
    resources :reviews, only: [:create]
  end

  namespace :admin do
    resources :videos, only: [:new, :create, :destroy]
    resources :payments, only: :index
  end

  resources :genres, except: :index
  resources :users, except: [:new, :index, :destroy]
  resources :queue_videos, only: [:create, :destroy]
  resources :followings, only: [:create, :destroy]

  get 'home', to: 'videos#index'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'
  get 'register', to: 'users#new'
  get 'people', to: 'followings#index'
  get 'my_queue', to: 'queue_videos#index'
  post 'update_queue', to: 'queue_videos#update_queue'

  get 'forgot_password', to: 'forgot_passwords#new'
  post 'forgot_password', to: 'forgot_passwords#create'
  get 'confirm_password_reset', to: 'pages#confirm_password_reset'
  get 'invalid_token', to: 'pages#invalid_token'
  get 'password_resets/:id', to: 'password_resets#show', as: 'password_reset'
  post 'reset_password', to: 'password_resets#create'

  get 'invite', to: 'invites#new'
  post 'invite', to: 'invites#create'
  get 'invited_registration', to: 'invited_registrations#new'

  mount Sidekiq::Web => '/sidekiq'
  mount StripeEvent::Engine => '/stripe_events'

  get 'ui(/:action)', controller: 'ui'
end
