Myflix::Application.routes.draw do
  root "pages#front"
  
  resources :users,      only: [:create, :show]
  get 'people', to: 'relationships#index'
  resources :relationships, only: [:create, :destroy]
  resources :sessions,   only: [:create]
  resources :categories, only: [:show]
  resources :queue_items,only: [:create, :destroy]
  resources :videos,     only: [:show] do
    collection do
      get :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
  get 'forgot_password', to: 'forgot_passwords#new'
  get 'forgot_password_confirmation', to: 'forgot_passwords#confirm'
  get 'expired_token', to: 'pages#expired_token'
  resources :password_resets, only: [:edit, :update]
  resources :forgot_passwords, only: [:create]
  resources :invitations, only: [:new, :create]

  post 'update_queue', to: 'queue_items#update_queue'
  get 'ui(/:action)', controller: 'ui'
  get 'my_queue', to: 'queue_items#index'
  get 'home',     to: 'videos#index'
  get 'register', to: "users#new"
  get 'register/:token', to: "users#new_with_invitation_token", as: "register_with_token"
  get 'sign_in',  to: "sessions#new"
  get 'sign_out', to: "sessions#destroy"

end
