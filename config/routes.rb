Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'videos#home'
  get '/show', to: 'videos#home'

  resources :videos	




end
