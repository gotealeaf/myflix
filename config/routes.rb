Myflix::Application.routes.draw do
  root to: "pages#front"
  get 'home', to: "videos#index"

  resources :videos, only: [:show] do
    collection do 
      get :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
  resources :categories, only: [:show]

  get 'ui(/:action)', controller: 'ui'
  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  get 'sign_out', to: 'sessions#destroy'
  get 'my_queue', to: 'queue_items#index'
  
  resources :users, only: [:create]
  resources :sessions, only: [:create]
end
