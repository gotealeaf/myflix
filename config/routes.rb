Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'
  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  get '/logout', to: 'sessions#destroy'
  get "/expired_token", to: "pages#expired"

  resources :videos do
    collection do
      get '/search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end
  get '/home', to: 'videos#index'

  namespace :admin do
    resources :videos, only: [:new, :create]
    resources :payments, only: [:index]
  end

  resources :relationships, only: [:destroy, :create]
  get '/people', to: 'relationships#index'

  resources :categories

  resources :users
  get '/register', to: 'users#new'
  get '/register/:token', to: 'users#new_with_invitation_token', as: 'register_with_token'

  resources :queue_items, only: [:create, :destroy]
  get '/my_queue', to: 'queue_items#index'
  post '/update_queue', to: 'queue_items#update_queue'

  resources :forgot_passwords, only: [:create]
  get "/forgot_password", to: 'forgot_passwords#new'
  get "/forgot_password_confirmation", to: 'forgot_passwords#confirm'

  resources :password_resets, only: [:show, :create]

  resources :invitations, only: [:new, :create]

  mount StripeEvent::Engine => '/stripe_event'
end
