Myflix::Application.routes.draw do
resources :videos
  get 'ui(/:action)', controller: 'ui'
end
