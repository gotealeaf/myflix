Myflix::Application.routes.draw do
  root "pages#front"

  get "home" => "pages#front"

  resources :videos, :only => [:index, :show] do
    get "search", on: :collection
  end

  resources :categories, :only => [:show]
  resources :users,      :only => [:new, :create]

  get "register" => "users#new"
  get "sign_in"  => "sessions#new"

  get 'ui(/:action)', controller: 'ui'
end
