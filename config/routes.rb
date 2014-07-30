Myflix::Application.routes.draw do
  root to: 'welcome#index'
  get 'home', to: "videos#index"

  get 'register', to: 'users#new' #create named route called users#new
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy'

  get 'ui(/:action)', controller: 'ui'

  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end

    member do
      post 'highlight', to: 'videos#highlight'
    end

    resources :reviews, only: [:create]
  end

  resources :categories, only: [:show]

  resources :users, only: [:new, :create, :show]
  
end
