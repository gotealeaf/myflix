Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  resources :videos, only: [:index, :show]
  get '/home', to: 'videos#index'

  resources :categories, only: [:show]
  get '/genre/:id', to: 'categories#show'

end
