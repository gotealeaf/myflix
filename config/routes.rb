Myflix::Application.routes.draw do
  root to: 'videos#index'

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get '/genre/:id', to: 'categories#show', as: 'genre'

  resources :videos, only: [:show]
end
