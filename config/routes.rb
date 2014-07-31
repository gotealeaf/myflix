Myflix::Application.routes.draw do
  root to: 'pages#front'

  resources :videos, only: [:show] do
    collection do
      post :search, to: 'videos#search'
    end
  end

  resources :categories, only: [:show]

  get 'ui(/:action)', controller: 'ui'

  get 'register', to: 'users#new'

  get 'sign_in', to: 'sessions#new'
  resources :users, only: [:create]

end
