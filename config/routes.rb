Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root                 to: 'pages#front'
  get     '/home',     to: 'categories#index'
  get     '/register', to: 'users#new'
  get     '/signin',   to: 'sessions#new'
  get     '/signout',  to: 'sessions#destroy'
  get     '/my_queue', to: 'queue_items#index'

  resources :categories,  only: [:show]
  resources :queue_items, only: [:create, :destroy]
  resources :sessions,    only: [:create]
  resources :users,       only: [:create, :show]
  resources :videos,      only: [:show] do
    collection do
      get  :search  #videos/search
    end
    resources :reviews,   only: [:create]
  end
end
