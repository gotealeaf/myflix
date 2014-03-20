Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'

  get 'home', to: 'videos#home'
  get 'register', to: 'users#new'


  resources :categories, only: [:show]
  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end
  resources :users, only: [:create]
end
