Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root to: 'pages#front'
  get '/home', to: 'videos#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'
  get '/my_queue', to: 'queue_items#index'
  
  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  resources :users, except: [:delete]
  resources :sessions, only: [:new, :create, :destroy]
  resources :categories, only: [:show]
  resources :queue_items, only: [:create]


end
