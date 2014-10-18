Myflix::Application.routes.draw do
  root to: 'pages#index'
  get '/register', to: "users#new"
  get '/signin', to: "sessions#new"
  post '/signin', to: "sessions#create"
  get '/signout', to: "sessions#destroy"
  get 'home', to: "pages#home"
  get 'ui/genre', to: "ui#genre"
  get 'ui(/:action)', controller: 'ui'
  get 'my_queue', to: "queue_items#index"
  resources :videos, only: [:show, :index] do
  	collection do
  		get :search, to: "videos#searchresults"
  	end
  	resources :reviews
  end
  resources :users
  resources :queue_items, only: [:create, :destroy]
  resources :categories, only: [:show]

end
