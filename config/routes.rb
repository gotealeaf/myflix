Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  
  root to: 'pages#front'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get '/register', to: 'users#new'
  
  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: 'videos#search'
    end
  end
  resources :users, except: [:delete]
  resources :sessions, only: [:create, :destroy]
  resources :categories, only: [:show]


end
