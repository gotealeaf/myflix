Myflix::Application.routes.draw do
  get 'home', to: 'videos#index'

  resources :videos, only: [:show]
  
  get 'ui(/:action)', controller: 'ui'
end
