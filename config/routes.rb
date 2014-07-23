Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  # have to set this up so there is only one videos#index
  # default home page
  get '/home' => 'videos#index', :as => :video
  # resources :videos, :path => 'home'
 resources :videos
end
