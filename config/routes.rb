Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get 'home', to: 'videos#home'
  get 'search', to: 'videos#search'

  resources :categories, only: :show
end
