Myflix::Application.routes.draw do
  root to: "pages#front"
  get '/home', to: 'videos#index'
  

  resources :videos, only: [:index, :show] do
    collection do
      post :search, to: "videos#search"
    end
  end
  resources :users, only: [:create]
  resources :categories, only: [:show]
  resources :sessions, only: [:create]
  get 'ui(/:action)', controller: 'ui'
  
  get 'register', to: "users#new"
  get 'sign_in', to: 'sessions#new'
  get 'sign_out' to: 'sessions#destroy'

end
