Myflix::Application.routes.draw do

  get '/home', to: 'videos#index'
  resources :videos, except: [:destroy] do
    collection do
      post 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  get '/genre/:id', to: 'categories#show', as: 'category'

  resources :queue_items, only: [:create, :destroy]
  get '/my_queue', to: 'queue_items#index'

  resources :sessions, only: [:create]
  resources :users, only: [:create]
  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'

  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'
end
