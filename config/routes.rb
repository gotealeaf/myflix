Myflix::Application.routes.draw do
	root to: "pages#front"

  get 'ui(/:action)', controller: 'ui'
	get 'home', to: 'videos#index'
	get 'register', to: "users#new"
	get 'sign_in', to: "sessions#new"
	get 'sign_out', to: "sessions#destroy"
  get 'my_queue', to: "queue_items#index"
  post 'update_queue', to: "queue_items#update_queue"
  get 'people', to: "relationships#index"
  get 'forgot_password', to: "forgot_passwords#new"
  get 'forgot_password_confirmation', to: "forgot_passwords#confirm"
  get 'expired_token', to: "pages#expired_token"
  get 'register/:token', to: "users#new_with_invitation_token", as: "register_with_token"
  
  namespace :admin do
    resources :videos, only: [:new, :create]
    resources :payments, only: [:index]
  end

  resources :videos do
  	collection do
  		post :search
  	end
    resources :reviews, only: [:create]
  end
  
  resources :categories
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:create, :destroy]
  resources :users, only: [:show]
  resources :relationships, only: [:create, :destroy]
  resources :forgot_passwords, only: [:create]
  resources :password_resets, only: [:show, :create]
  resources :invitations, only: [:new, :create]

  mount StripeEvent::Engine => '/stripe_events'
end
