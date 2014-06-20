Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: "pages#front"
  get "/home", to: "videos#index"
  get "/register", to: "users#new"
  get "/login", to: "sessions#new"
  post "/login", to: "sessions#create"
  get "/logout", to: "sessions#destroy"

  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: "videos#search"
    end

    resources :reviews, only: [:create, :update]
  end

  resources :categories, only: [:show]

  resources :users, only: [:create, :edit, :update, :show]

  
end
