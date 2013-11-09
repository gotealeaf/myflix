Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
  end
  root to: 'pages#front'
  get '/home', to: 'videos#index'
  resources :categories, only: [:show]

  get '/register', to: 'users#register'
  get '/sign_in', to: 'users#sign_in'

end
