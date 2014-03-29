Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'videos#index'

  get '/home', to: 'videos#index'

  resources :categories,  only: [:show]
  resources :videos,      only: [:show] do
    collection do
      get  :search  #videos/search
    end
  end
end
