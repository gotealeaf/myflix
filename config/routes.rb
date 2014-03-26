Myflix::Application.routes.draw do

  root to: 'pages#front'

  resources :videos, only: [:show, :index] do
    collection do
      post 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :users, only: [:create] # do
  #   member do
  #     resources :my_queues, only: [:index, :update]
  #   end
  # end 

  resources :sessions, only: [:create]

  get 'my_queue', to: 'queue_items#index'
  get 'ui(/:action)', controller: 'ui'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
end
