Myflix::Application.routes.draw do
  get "/home", to: "home#index"
  resources :videos
  get 'ui(/:action)', controller: 'ui'
end
