Myflix::Application.routes.draw do
  get 'sign_in', to: 'sessions#new'
  post 'log_in', to: 'sessions#create'
  get 'register', to: 'users#new'
  get 'log_out', to: 'sessions#destroy'
  get 'queue_items', to: 'queue_items#index'
  root to: 'pages#index' 

  resources :videos, only: [:index, :show] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :queue_items, only: [:create, :destroy]
  post 'sort', to: 'queue_items#sort'

  resources :categories, only: [:show] 
  resources :users, only: [:create]
  get 'ui(/:action)', controller: 'ui'
end
