Myflix::Application.routes.draw do
  root to: 'pages#front'
  
  resources :videos, only:[:show] do
    collection do
      post :search, to: "videos#search"
    end
  end
  resources :categories, only: [:show], path: 'genre'
  resources :users, only: [:create]
  
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: "videos#index"
  get 'show', to: "videos#show"
  get 'register', to: "users#new"
end
