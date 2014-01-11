Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  root to: 'videos#home'
  get '/home', to: 'videos#home'
  resources :videos do
    collection do
      post :search, to: 'videos#search'
    end
  end
  resources :categories, only: [:show]
end
