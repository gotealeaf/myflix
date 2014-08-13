Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: "pages#front"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: "videos#search"
    end

    resources :reviews, only: [:create, :update]
  end
  get "/home", to: "videos#index"

  resources :categories, only: [:show]

  resources :users, only: [:create, :show]
  get "/register", to: "users#new"
  get "/register/:token", to: "users#new_with_invite_token", as: "register_with_token"
  
  resources :queue_items, only: [:create, :destroy]
  get "/my_queue", to: "queue_items#index"
  post "/update_queue", to: "queue_items#update_queue"

  resources :followings, only: [:create, :destroy]
  get "/people", to: "followings#index"

  resources :password_resets, only: [:edit, :update]
  get "/forgot_password", to: "password_resets#new"
  post "/forgot_password", to: "password_resets#create"
  get "confirm_password_reset", controller: "password_resets"
  get "expired_token", controller: "password_resets"

  resources :invites, only:[:create]
  get "/invite", to: "invites#new"

  namespace :admin do
    resources :videos, only: [:new, :create]
  end
end
