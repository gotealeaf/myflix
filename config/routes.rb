Myflix::Application.routes.draw do
  root to: 'pages#front'
  resources :videos do
    get :search, to: 'videos#search', on: :collection
  end

  resources :genres, except: :index
  resources :users, except: [:new, :index, :destroy]

  get '/home', to: 'videos#index', as: :home
  get '/sign_in', to: 'sessions#new'
  post '/sign_in', to: 'sessions#create'
  get '/sign_out', to: 'sessions#destroy', as: :sign_out
  get '/register', to: 'users#new', as: :register
  get 'ui(/:action)', controller: 'ui'
end
