Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  # decided on this as most syntactically correct version
  get '/home' => 'videos#index', :as => :videos
  # this may change as development changes
  get '/video' => 'videos#show'
  # resources :videos, only: [:show, :index]
  resource :category
end
