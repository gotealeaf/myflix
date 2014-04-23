Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'

  get 'home', to: 'videos#index'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'my_queue', to: 'queue_items#index'
  patch 'update_queue', to: 'queue_items#update_queue'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :users, only: [:create, :new, :show] do
    post 'follow', to: 'users#follow'
  end

  resources :queue_items, only: [:create, :destroy]
  resources :categories, only: [:show]  
  resources :sessions, only: [:create]
end
