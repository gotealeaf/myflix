Myflix::Application.routes.draw do
  root to: 'pages#index'
  get '/register', to: "users#new"
  get '/signin', to: "sessions#new"
  post '/signin', to: "sessions#create"
  get '/signout', to: "sessions#destroy"
  get 'home', to: "pages#home"
  get 'ui/genre', to: "ui#genre"
  get 'ui(/:action)', controller: 'ui'
  resources :videos, only: [:show] do
  	collection do
  		get :search, to: "video#searchresults"
  	end
  end
  resources :users

end
