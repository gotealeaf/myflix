Myflix::Application.routes.draw do
  root to: 'videos#index'
  resources :videos
  resources :categories, :path => 'genre'
  get 'ui(/:action)', controller: 'ui'
end
