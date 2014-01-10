Myflix::Application.routes.draw do
	root to: 'pages#front'

  resources :videos, only: [:index,:show] do

  	collection do 
  		post 'search', to: 'videos#search'
  	end

  end

  resources :categories, only: [:show]
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  
  get 'home', to: "videos#index"
  get 'register', to: "users#new"
  get 'sign_in', to: "sessions#new"
  get 'sign_out', to: 'sessions#destroy'
end
