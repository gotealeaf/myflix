Myflix::Application.routes.draw do
  root to: 'pages#front'
  resources :videos do
    get :search, to: 'videos#search', on: :collection
    resources :reviews, only: [:create]
  end

  resources :genres, except: :index
  resources :users, except: [:new, :index, :destroy]
  resources :queue_videos, only: [:create, :destroy]
  resources :followings, only: [:create, :destroy]

  get 'home', to: 'videos#index'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'
  get 'register', to: 'users#new'
  get 'my_queue', to: 'queue_videos#index'
  get 'people', to: 'followings#index'

  get 'forgot_password', to: 'password_resets#new'
  post'forgot_password', to: 'password_resets#create'
  get 'confirm_password_reset', to: 'pages_controller#confirm_password_reset'

  post 'update_queue', to: 'queue_videos#update_queue'

  get 'ui(/:action)', controller: 'ui'
end
