Myflix::Application.routes.draw do
  root "pages#front"

  get "home" => "videos#index"

  resources :videos, :only => [:index, :show] do
    get "search", on: :collection
  end

  resources :categories, :only => [:show]
  resources :users,      :only => [:new, :create]
  resources :sessions,   :only => [:create]

  get "register"  => "users#new"
  get "sign_in"   => "sessions#new"
  get "sign_out" => "sessions#destroy"

  get 'ui(/:action)', controller: 'ui'
end
