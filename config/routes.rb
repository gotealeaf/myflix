Myflix::Application.routes.draw do
	root to: "pages#front"

  get 'ui(/:action)', controller: 'ui'
	get 'home', to: 'videos#index'
	get 'register', to: "users#new"
	get 'sign_in', to: "sessions#new"
	get 'sign_out', to: "sessions#destroy"
  get 'my_queue', to: "queue_items#index"
  post 'update_queue', to: "queue_items#update_queue"
  get 'people', to: "relationships#index"
  
  resources :videos do
  	collection do
  		post :search
  	end
    resources :reviews, only: [:create]
  end
  
  resources :categories
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:create, :destroy]
  resources :users, only: [:show]
  resources :relationships, only: [:create, :destroy]
end
