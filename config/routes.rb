Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'videos#index'

  get '/home', to: 'videos#index'

  resources :videos,      only: [:show]
  resources :categories,  only: [:show]


end
