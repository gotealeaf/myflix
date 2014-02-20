Myflix::Application.routes.draw do

  get '/home', to: 'videos#index'
  resources :videos, except: [:destroy] do
    collection do
      post 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  get '/genre/:id', to: 'categories#show', as: 'category'

  resources :relationships, only: [:create, :destroy]
  get '/people', to: 'relationships#index'

  resources :queue_items, only: [:create, :destroy]
  get '/my_queue', to: 'queue_items#index'
  post 'update_queue', to: 'queue_items#update_queue'

  resources :sessions, only: [:create]
  resources :users, only: [:show, :create]
  get '/register', to: 'users#new'
  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'

  resources :forgot_passwords, only: [:create]
  get '/forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'

  resources :password_resets, only: [:show, :create]
  get '/expired_token', to: 'password_resets#expired_token'

  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'
end
