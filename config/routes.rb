Myflix::Application.routes.draw do
	root to: 'pages#front'

  resources :videos, only: [:index,:show] do

  	collection do 
  		post 'search', to: 'videos#search'
  	end
    resources :reviews, only: [:create]
  end

  resources :categories, only: [:show]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:create, :destroy]
  resources :users, only: [:show, :create]
  resources :relationships, only: [:create,:destroy]

  get 'people', to: 'relationships#index'

  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'

  get 'home', to: 'videos#index'
  get 'register', to: 'users#new'
  
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'

  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'

  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'

  resources :invitations, only: [:new, :create]
end
