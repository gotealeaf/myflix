Myflix::Application.routes.draw do

  root to: 'pages#front'

  get '/register', to: 'users#new'

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get '/sign_in', to: 'sessions#new'
  
  get '/sign_out', to: 'sessions#destroy'
  get '/my_queue', to: 'queue_items#index'
  #post '/my_queue', to: 'queue_items#create'

  resources :videos, only: [:show] do
    
    resources :reviews, only: [:create]
    collection do 
      get 'search', to: 'videos#search'
    end
  end
  resources :categories, only: [:show]
  resources :users, except: [:destroy, :new]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:create, :destroy]
end
