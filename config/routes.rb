Myflix::Application.routes.draw do

  resources :videos, only: :show do
    collection do
      post 'search'
    end

    member do
      post 'queue'
      post 'dequeue'
    end

    resources :reviews, only: :create
  end

  resources :categories, only: :show

  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'
  get 'register', to: 'users#new'
  post 'register', to: 'users#create'

  resources :users, only: [:show, :edit, :update], path: '/account'

  resources :queue_items, only: [:index], path: '/my_queue'

  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'videos#index'
end
