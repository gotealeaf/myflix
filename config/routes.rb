Myflix::Application.routes.draw do

# root to: 'videos#index'
root to: 'pages#front'
resources :videos do
  collection do
    post :search, to: 'videos#search'
  end
end

resources :categories, only: [:show]

get 'register', to: 'users#new'
  get 'ui(/:action)', controller: 'ui'

  

end