Myflix::Application.routes.draw do

  root :to => 'pages#front'
  get 'home', to: 'videos#index'
  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'
  resources :queue_items, only: [:create, :destroy]
  get 'people', to: 'relationships#index'
  resources :relationships, only: [:create, :destroy]
    
  get 'ui(/:action)', controller: 'ui'
  resources :videos, only: [:show] do
    collection do
      get :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
  resources :categories
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  resources :users, only: [:create, :show]
  resources :sessions, only: [:create]
end
