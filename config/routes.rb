Myflix::Application.routes.draw do
  get 'sign_in', to: 'sessions#new'
  get 'register', to: 'users#new'
  root to: 'welcome#index'  

  resources :videos, only: [:index, :show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end
  
  resources :categories, only: [:show] 

  resources :users, only: [:create]
  resources :sessions, only: [:create]
  
  get 'ui(/:action)', controller: 'ui'
end
