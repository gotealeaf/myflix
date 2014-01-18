Myflix::Application.routes.draw do

root to: 'pages#front'
get 'home', to: 'videos#index'

get 'my_queue', to: 'queue_items#index'
resources :queue_items, only: [:create, :destroy]

resources :videos do
  collection do
    post :search, to: 'videos#search'
  end
  resources :reviews, only: [:create]
end
resources :reviews, only: [:create]
resources :categories, only: [:show]

get 'register', to: 'users#new'
resources :users, only: [:create]

get 'sign_in', to: 'sessions#new'
get 'sign_out', to: 'sessions#destroy'
resources :sessions, only: [:create]


  get 'ui(/:action)', controller: 'ui'

  

end