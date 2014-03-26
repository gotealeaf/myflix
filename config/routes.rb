Myflix::Application.routes.draw do
  root to: 'pages#root'

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/', to: 'pages#root'
  get '/register', to: 'users#new'
  post '/register', to: 'users#create'
  get '/logout', to: 'sessions#logout'
  get '/my_queue', to: 'queue_items#index'
  post '/update_form', to: 'queue_items#update_order'
  get '/people', to: 'followships#index'

  resources :videos, only: [:show, :index] do
    collection do
      get :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :followships, only: [:create, :destroy]

  resources :queue_items, only: [:create, :index, :destroy]

  resources :users, only: [:show, :create, :edit, :update]

  resources :categories
end
