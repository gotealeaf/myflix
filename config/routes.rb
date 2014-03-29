Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'categories#index'

  get '/home', to: 'categories#index'

  resources :categories,  only: [:show]
  resources :videos,      only: [:show] do
    collection do
      get  :search  #videos/search
    end
  end
end
