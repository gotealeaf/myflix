Myflix::Application.routes.draw do
	root 'pages#front'
	get 'register', to: "users#new"
	get 'sign_in', to: "sessions#new"
  get 'sign_out', to: "sessions#destroy"
  get 'home', to: "videos#index"
  get 'my_queue', to: 'queue_items#index'
  get 'ui(/:action)', controller: 'ui'

  resources :videos, only: [:show, :index] do
    collection do
    	post 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  resources :categories
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'

  resources :users, only: [:create, :show]

  resources :sessions, only: [:create, :destroy]


end


