Myflix::Application.routes.draw do
  root to: 'pages#front'

  get 'register', to: 'users#new'
  get 'home', to: 'videos#index'
  get 'my_queue', to: 'queue_items#index'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'ui(/:action)', controller: 'ui'

  resources :categories, only: [:show]
  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
  resources :users, only: [:create]
  resources :sessions, only: [:create, :destroy]
  resources :queue_items, only: [:create]
end
