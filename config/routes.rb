Myflix::Application.routes.draw do

  resources :categories, only: [:show]
  resources :videos, only: [:show]

  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'home#index', as: 'home'

  root to: 'home#index'
end
