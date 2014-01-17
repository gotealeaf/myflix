Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

	get '/home', to: 'videos#home'
  resources :videos do
  	collection do
  		post :search
  	end
  end
  resources :categories
end
