Myflix::Application.routes.draw do
	root to: 'pages#front'
	get 'ui(/:action)', controller: 'ui'
	get 'home', to: "videos#index"
	get 'register', to: "users#new"
	get 'sign_in', to: 'sessions#new'
	get 'sign_out', to: 'sessions#destroy'
	resources :videos, only: [:show, :index] do
		collection do
			post :search, to: "videos#search"
		end
	end
	resources :home, only: [:show]
  resources :genre, only: [:show]
  resources :users, only: [:create]
  resource :sessions, only: [:create]
end

