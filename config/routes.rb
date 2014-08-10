Myflix::Application.routes.draw do
  root to: 'pages#front'
  get 'home', to: "videos#index"
  
get 'ui(/:action)', controller: 'ui'
#get '/home' => 'videos#index', :as => :videos
get 'home', to: 'videos#show'
get 'register', to: 'users#new'
get 'sign_in', to: "sessions#new"
get 'sign_out', to: "sessions#destroy"

resources :sessions, only: [:create]
resources :users, only: [:create]
resources :categories, only: [:show]
resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
    resources :reviews, only: [:create]
  end
end
