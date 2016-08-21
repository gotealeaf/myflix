Myflix::Application.routes.draw do
	root 'videos#index'
  get 'ui(/:action)', controller: 'ui'

  resources :videos, only: [:index, :show] do 
  	collection do 
  		get :search
  	end
  end
  resources :categories, only: [:index, :show]
  get 'home', to: 'videos#index' 
end
