Myflix::Application.routes.draw do
  get 'sign_in', to: 'sessions#new'
  post 'log_in', to: 'sessions#create'
  get 'register', to: 'users#new'
  get 'log_out', to: 'sessions#destroy'
  get 'forgot_password', to: 'sessions#forgot_password'
  post 'send_token', to: 'sessions#send_token'
  get 'confirm_password', to: 'sessions#confirm_password'
  get 'reset_password', to: 'sessions#reset_password'
  patch 'update_password', to: 'sessions#update_password'
  get 'queue_items', to: 'queue_items#index'
  root to: 'pages#index' 

  resources :videos, only: [:index, :show] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :queue_items, only: [:create, :destroy]
  post 'sort', to: 'queue_items#sort'

  resources :categories, only: [:show] 
  resources :users, only: [:show, :index, :create]
  get 'ui(/:action)', controller: 'ui'
  resources :relationships, only: [:create, :destroy]
end
