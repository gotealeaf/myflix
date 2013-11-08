Myflix::Application.routes.draw do
  root to: 'videos#index'

  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'videos#index'

  resources :videos do
    collection do
      post 'search', to: 'videos#search'
    end
  end

  resources :categories
end
