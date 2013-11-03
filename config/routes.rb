Myflix::Application.routes.draw do
  root to: 'videos#index'
  resources :videos
  get 'ui(/:action)', controller: 'ui'
end
