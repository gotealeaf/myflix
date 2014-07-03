Myflix::Application.routes.draw do

  resources :categories, only: [:show]

  resources :videos, only: [:show,:index] do
    collection do
      get "search", to: 'videos#search'
    end
    resources :reviews, only:[:create]
  end

  get 'home', to: 'videos#index'

  resources :users, only: [:create,:new]

  resources :queue_items, only:[:create,:destroy] do
    collection do
      post "update_queue", to: 'queue_items#update_queue', as: 'update'
    end
  end
  get 'my-queue', to: 'queue_items#index', as: 'my_queue'

  resources :sessions, only: [:new,:create,:destroy]
  get 'sign-in', to: 'sessions#new', as: 'sign_in'
  get 'sign-out', to: 'sessions#destroy', as: 'sign_out'

  get 'front', to: 'pages#front', as: 'front'
  get 'register', to: 'users#new', as: 'register'
  get 'ui(/:action)', controller: 'ui'

  root 'pages#front'

end
