Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root                 to: 'pages#front'
  get     '/home',     to: 'categories#index'
  get     '/register', to: 'users#new'
  get     '/signin',   to: 'sessions#new'
  get     'signout',   to: 'sessions#destroy'

  resources :sessions,    only: [:create]
  resources :users,       except: [:new, :destroy]
  resources :categories,  only: [:show]
  resources :videos,      only: [:show] do
    collection do
      get  :search  #videos/search
    end
  end
end
