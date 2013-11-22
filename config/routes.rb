Myflix::Application.routes.draw do
  
  root to: 'users#front'
  
  get '/register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'
  
  resources :users, only: [:new, :create]
    
  resources :videos, only: [:index, :new, :create, :show] do 
    collection do
      get :search, to: "videos#search"
      get :recent, to: "videos#recent"
    end
    resources :reviews, only: [:create]
  end
  
  resources :categories, :path => 'genre'
  
  get 'ui(/:action)', controller: 'ui'
end
