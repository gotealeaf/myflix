Myflix::Application.routes.draw do
  root "ui#index"
  resources :videos, only: [:show] do
    collection do
      get :search, to: "videos#search"
    end
  end
  resources :categories, only: :show
  get 'home', to: 'videos#index'
  get 'ui(/:action)', controller: 'ui'
end
