Myflix::Application.routes.draw do
  root to: 'videos#index'

  get 'ui(/:action)', controller: 'ui'

  resources :categories, only: [:show]
  resources :videos, only: [:index, :show]
end
