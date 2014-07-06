Myflix::Application.routes.draw do
	root to: 'videos#index'
	get '/home', to: 'videos#index'
  get 'ui(/:action)', controller: 'ui'

  resources :videos
end
