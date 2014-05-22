Myflix::Application.routes.draw do
  root "pages#front"
  
  resources :users, only: [:create]
  resources :categories, only: [:show]
  resources :videos, only: [:show] do
    collection do
      get :search, to: "videos#search"
    end
  end

  get 'ui(/:action)', controller: 'ui'
  get 'home',     to: 'videos#index'
  get 'register', to: "users#new"
  get 'sign_in',  to: "sessions#new"
end
