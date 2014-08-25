Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'home', to: "videos#index"
  
get 'ui(/:action)', controller: 'ui'
#get '/home' => 'videos#index', :as => :videos
get 'home', to: 'videos#show'
get 'register', to: 'users#new'
get 'sign_in', to: "sessions#new"
get 'sign_out', to: "sessions#destroy"
get 'my_queue', to: 'queue_items#index'
post 'update_queue', to: 'queue_items#update_queue'
get 'people', to: 'relationships#index'
get 'forgot_password', to: 'forgot_passwords#new'
get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
get 'expired_token', to: 'password_resets#expired_token'

resources :forgot_passwords, only: [:create]
resources :relationships, only: [:destroy, :create]
resources :queue_items, only: [:create, :destroy]
resources :sessions, only: [:create]
resources :users, only: [:create, :show]
resources :categories, only: [:show]
resources :password_resets, only: [:show, :create]

  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
end
