Myflix::Application.routes.draw do
  resources :videos	
  resources :categories
  get 'ui(/:action)', controller: 'ui'
end
