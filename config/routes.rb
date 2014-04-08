Myflix::Application.routes.draw do
  get 'sign_in', to: 'sessions#new'
  post 'log_in', to: 'sessions#create'
  get 'register', to: 'users#new'
  get 'log_out', to: 'sessions#destroy'
  root to: 'pages#index' 

  resources :videos, only: [:index, :show] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :queue_items, only: [:create, :destroy]
  post 'sort', to: 'queue_items#sort'
  get 'queue_items', to: 'queue_items#index'

  resources :categories, only: [:show] 

  resources :users, only: [:show, :index, :create]
  get 'ui(/:action)', controller: 'ui'

  resources :relationships, only: [:create, :destroy]

  resources :forgot_passwords, only: [:create]
  get 'email_page', to: 'forgot_passwords#email_page'
  get 'confirm_password_reset', to: 'forgot_passwords#confirm_password_reset'

  resources :reset_passwords, only: [:show, :create]
  get 'expired_token', to: 'reset_passwords#expired_token'
end
