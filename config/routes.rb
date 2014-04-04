Myflix::Application.routes.draw do
  root to: 'pages#front'
  
  get 'ui(/:action)', controller: 'ui'
  
  resources :videos, only: [:show] do
    collection do
      get '/search', to: 'videos#search'
    end

    resources :reviews, only: [:create]    
  end
  get 'home', to: 'videos#index'
  resources :categories, only: [:show]  
  resources :users, only: [:create]
  get 'register', to: 'users#new'
  resources :sessions, only: [:create]
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  resources :queue_items, only: [:create, :destroy]
  get 'my_queue', to: 'queue_items#index'
end
