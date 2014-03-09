Myflix::Application.routes.draw do
  get "/home" => "videos#index"

  resources :videos, :only => [:index, :show] do
    get "search", on: :collection
  end

  resources :categories, :only => [:show]

  get 'ui(/:action)', controller: 'ui'
end
