Myflix::Application.routes.draw do

  root to: 'pages#front'

  get 'ui(/:action)', controller: 'ui'

  resources :videos, only: [:show, :index] do
    collection do
      post 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :users, only: [:create, :show, :update] 
  get 'profile', to: 'users#profile'
  get 'register', to: 'users#new'
  get 'register/:token', to: 'users#new_with_invitation_token', as: 'register_with_token'

  resources :queue_items, only: [:create, :destroy]
  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue' 

  resources :sessions, only: [:create]
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'

  resources :relationships, only: [:create, :destroy]
  get 'people', to: 'relationships#index'

  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirmation'
  get 'forgot_password', to: 'forgot_passwords#new'

  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'pages#expired_token'

  resources :invitations, only: [:new, :create]
end
