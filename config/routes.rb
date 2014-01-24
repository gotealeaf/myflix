Myflix::Application.routes.draw do
  root to: 'videos#index'

  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'videos#index'
  resources :videos, except: [:destroy]

  get '/genre/:id', to: 'categories#show', as: 'category'
end
