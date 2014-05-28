Myflix::Application.routes.draw do
  root to: "pages#front"
  

  resources :videos, only: [:index, :show] do
    collection do
      post :search, to: "videos#search"
    end
  end
  resources :users, only: [:create]
  resources :categories, only: [:show]
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index'
  get 'register', to: "users#new"
  get 'sign_in', to: 'sessions#new'
end
