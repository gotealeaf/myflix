Myflix::Application.routes.draw do
	root to: 'pages#front'
	get '/home', to: 'videos#index'
  get 'ui(/:action)', controller: 'ui'
  get '/registration', to: 'users#new'
  
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'

  resources :videos do
    collection do
      get 'search'
    end
  end
  resources :categories, only: [:show, :new, :create]  
  resources :users, only: [:show, :create, :edit, :update]
end
