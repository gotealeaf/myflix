Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'

  resources :videos, only: [:show, :index] do
    collection do
      get :search, to: 'videos#search'
    end
  end

  resources :users, only: [:show, :create, :edit, :update]


  resources :categories
end
