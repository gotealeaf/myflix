Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#home'

  resources :videos, only: [:show]
  resources :categories, only: [:show]
end
