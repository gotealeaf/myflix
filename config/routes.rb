Myflix::Application.routes.draw do
  root "ui#index"

  resources :categories, only: [:show]
  resources :videos, only: [:show] do
    collection do
      get :search, to: "videos#search"
    end
  end

  get 'home', to: 'videos#index'
  get 'ui(/:action)', controller: 'ui'
end
