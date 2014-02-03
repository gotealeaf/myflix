Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'home', to: 'videos#index'

  resources :videos, only: [:show, :index] do
    collection do
      post :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
  get 'ui(/:action)', controller: 'ui'
  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  get 'sign_out', to: "sessions#destroy"
  get 'my_queue', to: "queue_items#index"
  get 'people', to: "relationships#index"
  
  post 'update_queue', to: "queue_items#update_queue"

  resources :relationships, only: [:destroy, :create]
  resources :users, only: [:create, :show]
  resources :queue_items, only: [:create, :destroy]
  resources :sessions, only: [:create]
  resources :categories
  resources :reviews, only: [:create]
end
