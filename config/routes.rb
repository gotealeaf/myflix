Myflix::Application.routes.draw do
  
  resources :categories, only: [:show]
  resources :videos, only: [:show]
  
  get 'home', to: 'home#index', as: 'home'
  get 'ui(/:action)', controller: 'ui'
  
  root 'home#index'
  
end
