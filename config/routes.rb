Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'home', to: 'videos#index'

  resources :videos, only: [:show, :index] do
    collection do
      post :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  get 'ui(/:action)', controller: 'ui'
  get 'register', to: 'users#new'
  get 'register/:token', to: 'users#new_with_invitation_token', as: 'register_with_token'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'my_queue', to: 'queue_items#index'
  get 'people', to: 'relationships#index'
  
  post 'update_queue', to: 'queue_items#update_queue'

  resources :relationships, only: [:destroy, :create]
  resources :users, only: [:create, :show]
  resources :queue_items, only: [:create, :destroy]
  resources :sessions, only: [:create]
  resources :categories
  resources :reviews, only: [:create]

  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :forgot_passwords, only: [:create]
  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'
  resources :invitations, only: [:new, :create]
end
