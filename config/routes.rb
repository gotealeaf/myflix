Myflix::Application.routes.draw do

  root to: 'pages#front'

  resources :videos, only: [:show, :index] do
    collection do
      post 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :users, only: [:create, :show, :update] 
  resources :queue_items, only: [:create, :destroy]
  resources :sessions, only: [:create]
  resources :relationships, only: [:create, :destroy]

  get 'ui(/:action)', controller: 'ui'

  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue' 
   
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'

  get 'profile', to: 'users#profile'
  get 'register', to: 'users#new'

  get 'forgot_password', to: 'forgot_passwords#new'

  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirmation'

  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'

  get 'people', to: 'relationships#index'

end
