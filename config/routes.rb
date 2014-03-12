Myflix::Application.routes.draw do
 # root to: 'videos#index'
  root to: 'pages#front'
  get 'login', to: 'pages#login'
  get 'register', to: 'pages#register'

  get 'ui(/:action)', controller: 'ui'
  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
  end


  resources :categories, except: [:destroy]
end
