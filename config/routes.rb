Myflix::Application.routes.draw do
  root to: 'videos#index'
  resources :videos do
    collection do
      get :search, to: "videos#search"
    end
  end
  resources :categories, :path => 'genre'
  get 'ui(/:action)', controller: 'ui'
end
