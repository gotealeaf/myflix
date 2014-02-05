Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'

  resources :videos, only: [:show, :index] do
    collection do
      post :search, to: 'videos#search'
      get :search, to: 'videos#index'
    end
  end

  resources :categories
end
