Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'

  resources :users, only: [:create, :new, :show] do
    post 'follow', to: 'users#follow'
  end
  get 'register', to: 'users#new'
  get 'forgot_password', to: 'users#forgot_password'
  post 'reset_email', to: 'users#reset_email'
  get 'reset_password/:password_token', to: 'users#reset_password'
  post 'reset_password', to: 'users#reset_password'

  resources :sessions, only: [:create]
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'

  resources :user_relationships, only: [:create, :destroy]
  get 'people', to: 'user_relationships#index'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  get 'home', to: 'videos#index'

  resources :queue_items, only: [:create, :destroy]
  get 'my_queue', to: 'queue_items#index'
  patch 'update_queue', to: 'queue_items#update_queue'

  resources :categories, only: [:show]
end
