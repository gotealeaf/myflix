Myflix::Application.routes.draw do
  root to: 'pages#front'
  resources :videos, only: [:index, :show] do
    collection do
      post :search
    end
    resources :reviews, only: [:create]
    resources :queue_items, only: [:create, :destroy]
  end

  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'

  resources :users, only: [:create]
  resources :categories, only: [:show]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:index]

  get 'ui(/:action)', controller: 'ui'
end
