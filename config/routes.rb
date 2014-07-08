Myflix::Application.routes.draw do
  root to: "categories#index"

  get 'ui(/:action)', controller: 'ui'
  resources :categories
  resources :videos
end
