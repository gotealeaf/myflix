Myflix::Application.routes.draw do
	root 'pages#front'
	get 'register', to: "users#new"
	get 'sign_in', to: "sessions#new"
  get 'sign_out', to: "sessions#destroy"
  get 'home', to: "videos#index"
  get 'my_queue', to: 'queue_items#index'
  get 'ui(/:action)', controller: 'ui'

  #Password routes

  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :forgot_passwords, only: [:create]
  get 'expired_token', to: 'pages#expired_token'
  resources :password_resets, only: [:show, :create]

  # Videos and Reviews

  resources :videos, only: [:show, :index] do
    collection do
    	post 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  # Categories and Queue Items

  resources :categories
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'

  # Users and Sessions

  resources :users, only: [:create, :show]
  get 'people', to: 'relationships#index'
  resources :relationships, only: [:create, :destroy]
  resources :sessions, only: [:create, :destroy]
  resources :invitations, only: [:new, :create]
  get 'register/:token', to: "users#new_with_invitation_token", as: 'register_with_token'

  # Admin

  namespace :admin do
    resources :videos, only: [:new, :create]
    resources :payments, only: [:index]
  end

  mount StripeEvent::Engine => '/stripe_events'
end


