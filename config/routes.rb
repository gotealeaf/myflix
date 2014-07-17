Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'home#index'

  resources :video
  resources :category
end
