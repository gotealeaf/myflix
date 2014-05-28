Myflix::Application.routes.draw do
  root to: "pages#front"
  get 'home', to: 'videos#index'
  
  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: "videos#search"
    end
  end
  
  get 'ui(/:action)', controller: 'ui'  
  get 'register', to: 'users#new'
  get 'sign_in', to: 'sessions#new'
  get 'sign_out', to: 'sessions#destroy'
  
  resources :users, only: [:create]
  resources :sessions, only: [:create]
  resources :categories, only: [:show]  
end
