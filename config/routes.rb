Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
  end
  root to: 'videos#index'
  get '/home', to: 'videos#index'
  resources :categories, only: [:show]
end
