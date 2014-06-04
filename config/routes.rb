Myflix::Application.routes.draw do

  root to: "videos#front"

  get "/register", to: "users#new"
  get "/home", to: "videos#index"
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'

  resources :categories
  resources :users
  resource :session

  resources :videos, only: [:index,:show] do
    collection do
      post :search, to: 'videos#search'
    end
  end
  get 'ui(/:action)', controller: 'ui'
end
