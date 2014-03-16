Myflix::Application.routes.draw do
  get 'sign_in', to: 'sessions#new'
  post 'log_in', to: 'sessions#create'
  get 'register', to: 'users#new'
  get 'log_out', to: 'sessions#destroy', as: 'log_out'
  get 'que_items', to: 'que_items#index', as: 'que_items'
  post 'que_item', to: 'que_items#create', as: 'video_que_item'
  root to: 'pages#index' 

  resources :videos, only: [:index, :show] do
    collection do
      get 'search', to: 'videos#search'
    end
    resources :reviews, only: [:create]
  end

  resources :categories, only: [:show] 
  resources :users, only: [:create]
  get 'ui(/:action)', controller: 'ui'
end
