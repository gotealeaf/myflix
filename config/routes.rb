Myflix::Application.routes.draw do

  get '/home', to: 'videos#index', as: :home

  resources :videos, except: :index

  get 'ui(/:action)', controller: 'ui'
end
