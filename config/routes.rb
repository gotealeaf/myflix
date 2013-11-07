Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  resources :videos
  root to: 'videos#index'
  get '/home', to: 'videos#index'
  resources :categories, only: [:show]
end
