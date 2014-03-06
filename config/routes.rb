Myflix::Application.routes.draw do

  root to: 'public_pages#front'
  get '/register', to: 'users#new'

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#home'

  resources :videos, only: [:show] do
    collection do 
      get 'search', to: 'videos#search'
    end
  end
  resources :categories, only: [:show]
  resources :users, except: [:destroy]
end
