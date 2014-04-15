Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  resources :videos
  get '/search', to: 'videos#search'
  #get '/', to: 'front#index'
  resources :users, only: [:new, :create, :edit, :update]
  resources :sessions, only: [:new, :create, :destroy]
  resources :reviews, only:[:create, :update]
  root to: 'front#index'
  
  get '/logout', to: 'sessions#destroy'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  resources :queues, only:[:create, :destroy] do
    collection do
      post 'update_instant'
    end
  end
  get '/my_queue', to: 'queues#index' 
end
