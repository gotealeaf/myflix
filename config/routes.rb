Myflix::Application.routes.draw do
	root to: 'pages#front'

  resources :videos, only: [:index,:show] do

  	collection do 
  		post 'search', to: 'videos#search'
  	end
    resources :reviews, only: [:create]
  end

  resources :categories, only: [:show]
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:create, :destroy]

  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'

  get 'home', to: 'videos#index'
  get 'register', to: 'users#new'
  
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
end
