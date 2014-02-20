Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  #get '/home', to: 'videos#home'
  #get '/video/:id', to: 'videos#video'

  resources :videos	




end
