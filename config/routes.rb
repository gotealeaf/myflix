Myflix::Application.routes.draw do

  root :to => 'pages#front'
  get 'ui(/:action)', controller: 'ui'
  resources :videos, only: [:show] do
    collection do
      get :search, to: "videos#search"
    end
  end
  resources :categories
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  resources :users, only: [:create]
end
