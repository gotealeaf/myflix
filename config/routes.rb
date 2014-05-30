Myflix::Application.routes.draw do

  resources :categories, only: [:show]
  resources :videos, only: [:show, :index] do
    collection do
      post :search, to: 'videos#search'
    end
  end

  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'home#index', as: 'home'
  get 'register', to: 'register#index', as: 'register'
  get 'sign_in', to: 'sign_in#index', as: 'sign_in'

  root to: 'home#index'
end
