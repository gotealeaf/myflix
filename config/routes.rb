Myflix::Application.routes.draw do

  root to: 'pages#front'

  get '/register', to: 'users#new'

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#home'
  get '/sign_in', to: 'sessions#new'
  #post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  resources :videos, only: [:show] do
    collection do 
      get 'search', to: 'videos#search'
    end
  end
  resources :categories, only: [:show]
  resources :users, except: [:destroy]
  resources :sessions, only: [:create]
  
end
