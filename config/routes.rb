Myflix::Application.routes.draw do
  root to: 'videos#index'

  get 'ui(/:action)', controller: 'ui'

  resources :videos, only: [:show]

  resources :categories, only: [:show]

end
