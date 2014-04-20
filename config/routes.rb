Myflix::Application.routes.draw do

  root to: 'pages#front'

  resources :videos, only: [:show, :index] do
    collection do
      post 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :users, only: [:create]
  resources :queue_items, only: [:create, :destroy]
  resources :sessions, only: [:create]

  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue' 
  get 'ui(/:action)', controller: 'ui'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
end
