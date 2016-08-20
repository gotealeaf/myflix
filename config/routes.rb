Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  resources :videos, only: [:index, :show]
  resources :categories, only: [:index, :show]
  get 'home', to: 'videos#index' 
end
