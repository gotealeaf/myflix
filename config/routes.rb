Myflix::Application.routes.draw do
  root to: "pages#front"
  get 'home', to: 'videos#index'

  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end

  resources :users, only: [:show]

  resources :categories, only: [:show]
  resources :queue_items, only: [:create, :destroy]
  post 'update_queue', to: 'queue_items#update_queue'

  get 'my_queue', to: 'queue_items#index'

  get 'ui(/:action)', controller: 'ui'
  get 'register', to: 'users#new'
  get 'register/:token', to: "users#new_with_invitation_token", as: 'register_with_token'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'

  resources :users, only: [:create]
  get 'people', to: 'relationships#index'
  resources :relationships, only: [:create, :destroy]
  resources :sessions, only: [:create]

  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'

  resources :password_resets, only: [:show, :create]
  get 'expired_token', to: 'pages#expired_token'

  resources :invitations, only: [:new, :create]

end
