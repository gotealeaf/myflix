Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  # default home page
  # get '/home', to: 'videos#index'
  resources :videos, :path => 'home'
end
