Myflix::Application.routes.draw do

  resources :videos, only: [:show] do
    resources :reviews, only: [:create]
    collection do 
      get 'search', to: 'videos#search'
    end
  end  
  get 'home', to: 'videos#index'

  resources :categories, only: [:show]

  resources :users, only: [:create]
  get 'register', to: 'users#new'
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  get 'logout', to: 'sessions#destroy'

  get 'queue', to: 'queue_items#index'
  
  root 'static_pages#front'

  get 'ui(/:action)', controller: 'ui'
end