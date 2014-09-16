Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root 'pages#front'
  get 'register', to: 'users#new'
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

  resources :relationships, only: [:destroy]

  resources :sessions, only: [:new, :create]

  resources :users, only: [:new, :create, :show] do
    collection do
      post 'start_session', to: 'users#start_session'
    end
  end
  resources :categories, only: :show
end
