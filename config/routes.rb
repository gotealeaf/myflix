Myflix::Application.routes.draw do
	root 'pages#front'
	get 'register', to: "users#new"
	get 'sign_in', to: "sessions#new"
  get 'sign_out', to: "sessions#destroy"
  get 'home', to: "videos#index"
  get 'my_queue', to: 'queue_items#index'
  get 'ui(/:action)', controller: 'ui'

  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :forgot_passwords, only: [:create]
  get 'expired_token', to: 'password_resets#expired_token'
  resources :password_resets, only: [:show, :create]

  resources :videos, only: [:show, :index] do
    collection do
    	post 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  resources :categories
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'

  resources :users, only: [:create, :show]
  get 'people', to: 'relationships#index'
  resources :relationships, only: [:create, :destroy]

  resources :sessions, only: [:create, :destroy]

  resources :invitations, only: [:new, :create]
end


