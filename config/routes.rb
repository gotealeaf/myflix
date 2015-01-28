Myflix::Application.routes.draw do
  root to: 'pages#front'
  get '/home', to: 'videos#index'
  get 'ui(/:action)', controller: 'ui'
  get '/registration', to: 'users#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/my_queue', to: 'my_queue_videos#index'
  post '/update_queue_videos', to: 'my_queue_videos#update_queue_videos'

  resources :videos do
    collection do
      get 'search'
    end
    resources :reviews, only: [:create]
  end
  resources :categories, only: [:show, :new, :create]  
  resources :users, only: [:show, :create, :edit, :update]
  
  resources :my_queue_videos, only: [:create, :destroy, :index]
  

end
