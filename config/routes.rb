Myflix::Application.routes.draw do
  get 'log_in', to: 'sessions#create'
  get 'signup', to: 'users#new'
  root to: 'welcome#index'  

  resources :videos, only: [:index, :show] do
    collection do
      get 'search', to: 'videos#search'
    end
  end
  
  resources :categories, only: [:show] 
  
  get 'ui(/:action)', controller: 'ui'
end
