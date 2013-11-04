Myflix::Application.routes.draw do
	root to: 'home#index'
	resources :videos
	resources :home
  get 'ui(/:action)', controller: 'ui'
  resources :genre
end

