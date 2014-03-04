Myflix::Application.routes.draw do

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#home'

  resources :videos, only: [:show] do
    collection do 
      get 'search', to: 'videos#search'
    end
  end
  resources :categories, only: [:show]
end
