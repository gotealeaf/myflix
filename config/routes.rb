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

  get '/people', to: 'relationships#index'

  get '/forgot_password', to: 'reset_password#new'
  post '/forgot_password', to: 'reset_password#create'
  get '/confirm_password', to: 'reset_password#confirm'
  get '/password_followup_expired', to: 'reset_password_followup#expired'

  post '/queue_list', to: 'queue_items#update_queue_list'

  resources :users, only: [:create, :show] do
    resources :relationships, only: [:create]
  end
  resources :categories, only: [:show]
  resources :sessions, only: [:create]
  resources :queue_items, only: [:index]
  resources :relationships, only: [:destroy]
  resources :reset_password_followup, only: [:show, :create]

  get 'ui(/:action)', controller: 'ui'
end
