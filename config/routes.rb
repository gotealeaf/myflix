Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
  end
  root to: 'pages#front'
  get 'home', to: 'videos#index'
  resources :categories, only: [:show]

  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  resources :users, only: [:create]
  resources :sessions, only: [:create]

end
