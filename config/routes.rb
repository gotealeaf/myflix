Myflix::Application.routes.draw do
  root to: 'pages#front'
  
  resources :videos, only:[:show] do
    collection do
      post :search, to: "videos#search"
    end
  end
  resources :categories, only: [:show], path: 'genre'
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: "videos#index"
  get 'show', to: "videos#show"
  get 'register', to: "users#new"
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
end
