Myflix::Application.routes.draw do
  root to: 'videos#index'
  get '/home', to: 'videos#index', as: :home

  resources :videos, except: :index do
    collection do
      get :search, to: 'videos#search'
    end
  end

  resources :genres, except: :index

  get 'ui(/:action)', controller: 'ui'
end
