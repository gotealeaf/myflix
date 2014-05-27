Myflix::Application.routes.draw do

  resources :categories, only: [:show]
  resources :videos, only: [:show] do
    collection do
      post :search, to: 'videos#search'
    end
  end

  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'home#index', as: 'home'

  root to: 'home#index'
end
