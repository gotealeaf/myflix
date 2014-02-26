Myflix::Application.routes.draw do
  resources :videos do
    collection do
      get 'search', to: 'videos#search'
    end
  end
  
  resources :categories, only: [:show] 
  
  get 'ui(/:action)', controller: 'ui'
end
