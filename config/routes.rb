Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

#  The following two routes are alternates that send the user home  
#  get 'home', controller: 'videos', action: 'index'
  get 'home', to: 'videos#index'

#limit routes to those actions supported by controller
  resources :videos, only: [:index, :show]
  resources :categories, only: :show
end
