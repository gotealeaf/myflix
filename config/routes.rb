Myflix::Application.routes.draw do
	root to: 'pages#front'
	get 'ui(/:action)', controller: 'ui'
	get 'register', to: "users#new"
	resources :videos, only: [:show, :index] do
		collection do
			post :search, to: "videos#search"
		end
	end
	resources :home, only: [:show]
  resources :genre, only: [:show]
  resources :users, only: [:create]
end

