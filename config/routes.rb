Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: "pages#front"
  get "/home", to: "videos#index"
  get "/register", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"
  get "/my_queue", to: "queue_items#index"
  post "/update_queue", to: "queue_items#update_queue"
  get "/people", to: "followings#index"
  get "/forgot_password", to: "password_resets#new"
  post "/forgot_password", to: "password_resets#create"
  get "confirm_password_reset", controller: "password_resets"
  get "expired_token", controller: "password_resets"


  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: "videos#search"
    end

    resources :reviews, only: [:create, :update]
  end

  resources :categories, only: [:show]

  resources :users, only: [:create, :show]
  
  resources :queue_items, only: [:create, :destroy]

  resources :followings, only: [:create, :destroy]

  resources :password_resets, only: [:edit, :update]
end
