Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  resources :videos
  root to: 'videos#index'
  get '/videos', to: 'videos#index', as: 'home'
  
end
