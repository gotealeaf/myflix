Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: "videos#index"

  resources :videos, only: [:index, :show] do
    collection do
      get :search, to: "videos#search"
    end
  end

  resources :categories, only: [:show]
end
