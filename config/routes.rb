Myflix::Application.routes.draw do

  root :to => 'videos#home'
  get 'ui(/:action)', controller: 'ui'
  resources :videos, only: [:show] do
    collection do
      get :search, to: "videos#search"
    end
  end
  resources :categories
end
