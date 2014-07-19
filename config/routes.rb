Rails.application.routes.draw do

  get '/', to: "categories#index"

  get 'ui(/:action)', controller: 'ui'

  resources :videos, excep: [:index]
  resources :categories, only: [:index, :show]

end
