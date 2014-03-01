Myflix::Application.routes.draw do
  get "/home" => "videos#index"

  resources :videos, :only => [:index, :show]

  get 'ui(/:action)', controller: 'ui'
end
