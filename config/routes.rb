Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'videos#home'

  get 'home', to: 'videos#home'

  resources :categories, only: :show
  resources :videos, only: :show do
    collection do
      get 'search', to: 'videos#search'
    end
  end
end
