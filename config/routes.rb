Myflix::Application.routes.draw do
  root to: 'pages#front'

  get 'ui(/:action)', controller: 'ui'

  get '/home', to: 'videos#index'
  resources :videos, except: [:destroy] do
    collection do
      post 'search', to: 'videos#search'
    end
  end

  get '/genre/:id', to: 'categories#show', as: 'category'

  get '/register', to: 'users#new'
  resources :users, only: [:create]

  get '/sign_in', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'
  resources :sessions, only: [:create]
end
