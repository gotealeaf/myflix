Myflix::Application.routes.draw do
	root 'videos#index'

  get 'ui(/:action)', controller: 'ui'

  resources :videos, only: [:show, :index] do
    collection do
    	post 'search', to: 'videos#search'
    end
  end
  resources :categories
end


