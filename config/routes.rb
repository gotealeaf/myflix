Myflix::Application.routes.draw do
  root to: "pages#front"
  get 'home', to: 'videos#index'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'my_queue', to: "queue_items#index"
  
  resources :videos, only: [:index, :show] do
    collection do 
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
    
  resources :categories, only: [:show]
  resources :users, only: [:new, :create, :show]
  resources :sessions, only: [:create]

  resources :queue_items, only: [:index, :create, :destroy]
  
  get 'ui(/:action)', controller: 'ui'
end
