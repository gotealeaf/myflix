Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'pages#front'

  if !defined?(session[:user_id])
    get 'home', to: redirect('sign_in')
  end

  get 'home', to: 'videos#home'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'

  resources :categories, only: [:show]
  resources :videos, only: [:show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end
  resources :users, only: [:create, :new]
end
