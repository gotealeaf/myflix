Myflix::Application.routes.draw do
  root to: 'pages#front'
  get '/home', to: 'videos#index'
  get 'ui(/:action)', controller: 'ui'
  get '/registration', to: 'users#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  get '/my_queue', to: 'my_queues#show'

  resources :videos do
    collection do
      get 'search'
    end
    resources :reviews, only: [:create]
  end
  resources :categories, only: [:show, :new, :create]  
  resources :users, only: [:show, :create, :edit, :update]
  resources :my_queues, only: [:show] 

  

end
