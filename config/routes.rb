Myflix::Application.routes.draw do
	root 'pages#front'
  get 'ui(/:action)', controller: 'ui'

  resources :videos, only: [:index, :show] do 
  	collection do 
  		get :search
  	end
  end
  resources :categories, only: [:index, :show]
  get 'home', to: 'videos#index' 
  get 'register', to: 'users#new'
  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'
  resources :users, only: [:create]
  resources :sessions, only: [:create]
end
