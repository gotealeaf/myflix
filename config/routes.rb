Myflix::Application.routes.draw do
  root "ui#index"
  resources :videos,     only: :show
  resources :categories, only: :show
  get 'home', to: 'videos#index'
  get 'ui(/:action)', controller: 'ui'
end
