Myflix::Application.routes.draw do

  get '/home', to: 'videos#index', as: 'home'

  get 'ui(/:action)', controller: 'ui'
end
