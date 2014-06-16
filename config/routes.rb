Myflix::Application.routes.draw do

  resources :categories, only: [:show]

  resources :videos, only: [:show,:index] do
    collection do
      get "search", to: 'videos#search'
    end
  end

  get 'home', to: 'videos#index'

  resources :users, only: [:create,:new]

  resources :sessions, only: [:new,:create,:destroy]
  get 'sign-in', to: 'sessions#new', as: 'sign_in'
  get 'sign-out', to: 'sessions#destroy', as: 'sign_out'

  get 'front', to: 'pages#front', as: 'front'
  get 'register', to: 'users#new', as: 'register'
  get 'ui(/:action)', controller: 'ui'

  root 'pages#front'

end
