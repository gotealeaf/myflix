Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root 'pages#front'
  get 'register', to: 'users#new'
  get 'register/:token', to: 'users#new_with_invitation_token', as: 'register_with_token'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  get 'my_queue', to: 'queue_items#index'
  get 'people',   to: 'relationships#index'

#  The following two routes are alternates that send the user home  
#  get 'home', controller: 'videos', action: 'index'
  get 'home', to: 'videos#index'



#limit routes to those actions supported by controller
  resources :videos, only: [:index, :show] do
    collection do
      get 'search', to: 'videos#search'
    end

    #nested
    resources :reviews, only: [:create]
  end

  resources :queue_items, only: [:index, :create, :destroy] do
    collection do
      post 'update_all', to: 'queue_items#update'
    end
  end

  resources :relationships, only: [:destroy, :create]
  resources :invitations, only: [:new, :create]

  resources :categories, only: :show

  resources :users, only: [:new, :create, :show] do
    collection do
      post 'start_session', to: 'users#start_session'
    end
  end
  resources :sessions, only: [:new, :create]

####################################################
  get 'forgot_password', to: 'forgot_passwords#new'
  resources :forgot_passwords, only: [:create]

  get 'confirm_password', to: 'forgot_passwords#confirm'

  resources :password_resets, only: [:show, :create]
####################################################
  get 'invalid_token', to: 'pages#invalid_token'

end
