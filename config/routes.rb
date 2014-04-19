Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get '/show/:id', to: 'videos#show', as: 'show'

  resources :categories
end
