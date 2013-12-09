Myflix::Application.routes.draw do
  root to: 'videos#index'

  resources :videos, only: [:show]

  get 'ui(/:action)', controller: 'ui'
end
