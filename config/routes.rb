Myflix::Application.routes.draw do
  root to: 'videos#index'
  resources :videos, only: [:show] do
    collection do
      post :search, to: "videos#search"
    end
  end


  resources :categories, except: [:destroy]
end
