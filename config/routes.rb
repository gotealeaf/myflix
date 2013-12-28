Myflix::Application.routes.draw do
	root 'videos#index'

  get 'ui(/:action)', controller: 'ui'

  resources :videos
  resources :categories
end


