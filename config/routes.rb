Rails.application.routes.draw do

  root to: "videos#index"

  get 'ui(/:action)', controller: 'ui'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

  resources :videos do
    resources :reviews, only: [:create]
  end
  resources :categories, only: [:index, :show]
  resources :users

  get 'search', to: 'search#index'


  resources :queue_items, only: [:create, :destroy]
  get '/my_queue', to: "queue_items#index"
  post "update_queue", to: "queue_items#update_queue"

  resources :relationships, only: [:show, :create, :destroy]
  get "following_people", to: "users#following"

  get '/forgot_password', to: "forgot_password#new"
  post '/forgot_password', to: "forgot_password#create"

  get '/password_reset', to: "password_reset#show"
  post '/password_reset', to: "password_reset#create"
end
