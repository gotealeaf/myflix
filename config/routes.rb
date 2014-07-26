Rails.application.routes.draw do

  root to: "videos#index"

  get 'ui(/:action)', controller: 'ui'
  get '/signin', to: 'sessions#new'
  post '/signin', to: 'sessions#create'
  get '/signout', to: 'sessions#destroy'

  get '/my_queue', to: "queue_items#index"

  resources :videos do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  resources :categories, only: [:index, :show]
  resources :users

  resources :queue_items, only: [:create, :destroy]
  post "update_queue", to: "queue_items#update_queue"
end
