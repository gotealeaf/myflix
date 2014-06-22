Myflix::Application.routes.draw do
  root 'videos#index'

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'

  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
  end

  resources :categories, only: [:show]
end
