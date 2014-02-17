Myflix::Application.routes.draw do

  root to: 'pages#front'

  resources :videos, only: :show do
    collection do
      post 'search', to: 'videos#search'
    end
  end

  get 'ui(/:action)', controller: 'ui'
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  resources :users, only: [:create]

  # get '/home', to: 'ui#home'
  # get '/video', to: 'ui#video'
  # get '/genre/:id', to: 'ui#genre'

  
end
