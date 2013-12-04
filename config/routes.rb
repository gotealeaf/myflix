Myflix::Application.routes.draw do
  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
  root to: 'pages#front'

  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'
  get 'my_queue', to: 'queue_items#index'
  

  get 'home', to: 'videos#index'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'

  get 'people', to: 'relationships#index'
  resources :relationships, only: [:destroy, :create]

  resources :users, only: [:create, :show]
  resources :sessions, only: [:create]
  resources :categories, only: [:show]

  get 'ui(/:action)', controller: 'ui'
  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'password_resets#expired_token'

  resources :invitations, only: [:new, :create]
end
