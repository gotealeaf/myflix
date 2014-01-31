Myflix::Application.routes.draw do

  root to: 'pages#front'
  get 'home', to: 'videos#index'

  get 'people', to: 'relationships#index'
  resources :relationships, only: [:destroy, :create]

  get 'register', to: 'users#new'
  resources :users, only: [:create, :show]

  get 'my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'
  resources :queue_items, only: [:create, :destroy]

  resources :videos do
    collection do
      post :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :reviews, only: [:create]

  resources :categories, only: [:show]

  get 'register', to: 'users#new'
  resources :users, only: [:create, :show]

  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  resources :forgot_passwords, only: [:create]

  get 'reset_password', to: 'reset_passwords#show'


  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  resources :sessions, only: [:create]

  get 'ui(/:action)', controller: 'ui'
end