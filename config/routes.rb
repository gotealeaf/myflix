Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get 'home', controller: 'videos', action: 'index'
  resources :videos
end
