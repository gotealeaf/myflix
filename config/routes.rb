Myflix::Application.routes.draw do
  
  resources :categories, only: [:show]
  resources :videos, only: [:show] do
    collection do
      get "search", to: 'videos#search'
    end
  end
  
  get 'home', to: 'home#index', as: 'home'
  get 'ui(/:action)', controller: 'ui'
  
  root 'home#index'
  
end
