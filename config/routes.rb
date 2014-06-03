Myflix::Application.routes.draw do
  get "/home", to: "videos#index"

  resources :categories

  resources :videos, only: [:index,:show] do
    collection do
      post :search, to: 'videos#search'
    end
  end
  get 'ui(/:action)', controller: 'ui'
end
