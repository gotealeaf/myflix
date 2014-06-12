Myflix::Application.routes.draw do
  root to: 'pages#front'

  get '/register', to: 'users#new'
  get 'ui(/:action)', controller: 'ui'

  resources :categories, only: [:show]
  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: "videos#search"
    end
  end
  resources :users, only: [:new, :create, :show, :edit, :update]

end
