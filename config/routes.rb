Myflix::Application.routes.draw do
  root to: 'pages#root'

  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get '/login', to: 'sessions#new'
  post '/login_now', to: 'sessions#create'
  get '/', to: 'pages#root'
  get '/register/(:invite_token)', to: 'users#new', as: "register"
  post '/register', to: 'users#create'
  get '/logout', to: 'sessions#logout'
  get '/my_queue', to: 'queue_items#index'
  post '/update_form', to: 'queue_items#update_order'
  get '/people', to: 'followships#index'
  post '/password_reset', to: 'password_resets#create'
  get '/reset_request_confirmation', to: 'password_resets#confirmation'
  get '/reset_password', to: 'password_resets#new'
  patch '/password_resets/:token', to: 'password_resets#update', as: "password_resets"

  resources :invitations, only: [:create, :new]

  resources :videos, only: [:show, :index] do
    collection do
      get :search, to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :password_resets, only: [:create, :edit, :new, :update]

  resources :followships, only: [:create, :destroy]

  resources :queue_items, only: [:create, :index, :destroy]

  resources :users, only: [:show, :create, :edit, :update]

  resources :categories
end
