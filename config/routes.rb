Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  root to: 'videos#index'

  get '/home', to: 'videos#index'

  resources :videos, except: [:index] do
    collection do
      post :search, to: "videos#search"
    end
  end

  # test test
end
