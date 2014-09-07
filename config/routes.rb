Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  resources :videos
  get '/home', to: 'videos#index'
  resources :categories
end
