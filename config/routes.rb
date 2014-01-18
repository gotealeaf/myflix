Myflix::Application.routes.draw do
	root to: "pages#front"

  get 'ui(/:action)', controller: 'ui'
	get '/home', to: 'videos#home'
	get 'register', to: "users#new"
	get 'sign_in', to: "sessions#new"
  
  resources :videos do
  	collection do
  		post :search
  	end
  end
  
  resources :categories
  resources :users, only:[:create]
end
