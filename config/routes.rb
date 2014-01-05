Myflix::Application.routes.draw do
  root to: 'videos#index'

  resources :videos, only: [:show] do
    collection do
      post :search
    end
  end
  resources :categories, only: [:show]

  get 'ui(/:action)', controller: 'ui'
end
