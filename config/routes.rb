Myflix::Application.routes.draw do
resources :videos

resources :categories, only: [:show]


  get 'ui(/:action)', controller: 'ui'
end
