Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui' 
  root to: "pages#front"
  get "/home", to: "videos#index"  
  resources :videos, only:[:index, :show] do
    collection do
      post "search"
    end
  end
  #get '/videos/:id', to: "videos#show", as: "video"
  get '/categories/:id', to: "categories#show", as: "category"
  get '/register', to: "users#new"
  get '/sign_in', to: "sessions#new"
  post '/login', to: "sessions#login"
  resources :users, only:[:create]


end
