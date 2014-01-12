Myflix::Application.routes.draw do

# root to: 'videos#index'
root to: 'pages#front'
get 'home', to: 'videos#index'
resources :videos do
  collection do
    post :search, to: 'videos#search'
  end
end

resources :categories, only: [:show]

get 'register', to: 'users#new'
get 'sign_in', to: 'sessions#new'
get 'sign_out', to: 'sessions#destroy'
resources :sessions, only: [:create]
resources :users, only: [:create]
  get 'ui(/:action)', controller: 'ui'

  

end