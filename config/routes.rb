Myflix::Application.routes.draw do
  resources :videos do
    collection do
      post :search, to: 'videos#search'
    end
  end
  resources :categories, only: [:show]
  resources :users, only: [:create]
  resources :sessions, only: [:create]

  root to: 'pages#front'
  get 'home', to: 'videos#index'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'

  get 'ui(/:action)', controller: 'ui'
end
