require 'sidekiq/web'
Myflix::Application.routes.draw do
  
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: '/letter_opener'
    mount Sidekiq::Web => '/sidekiq'
  end
  
  get 'ui(/:action)', controller: 'ui'
  
  root to: 'pages#front'  
  
  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  
  namespace :admin do
    resources :videos, only: [:new, :create]
    resources :payments, only: [:index]
  end
  
  resources :users, except: [:delete]
  resources :sessions, only: [:new, :create, :destroy]
  resources :categories, only: [:show]
  resources :queue_items, only: [:create, :destroy]
  resources :relationships, only: [:create, :destroy]
  resources :forgot_passwords, only: [:create]
  resources :password_resets, only: [:show, :create]
  resources :invitations, only: [:new, :create]
  
  get '/home', to: 'videos#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'
  get '/profile', to: 'users#edit'
  get '/register/:token', to: 'users#new_with_token', as: 'register_with_token'
  get '/my_queue', to: 'queue_items#index'
  post '/update_queue', to: 'queue_items#update_queue'
  get '/people', to: 'relationships#index'
  get '/forgot_password', to: 'forgot_passwords#new'
  get '/forgot_password_confirmation', to: 'forgot_passwords#confirm'
  get '/invalid_token', to: 'pages#invalid_token'
  get '/billing', to: 'users#billing'
  
  mount StripeEvent::Engine => '/stripe_events'

end
