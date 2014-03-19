Myflix::Application.routes.draw do
  root 'videos#index'

  get 'ui(/:action)', controller: 'ui'

  get 'home', to: 'videos#index'

  resources :categories, only: [:show]
  resources :videos, only: [:show] do
    collection do 
      get 'search', to: 'videos#search'
    end
  end
end