Myflix::Application.routes.draw do
  #this path was in video
  root to: "videos#index"


  # decided on this as most syntactically correct version
  # removing my version for solution version
  # get '/home' => 'videos#index', :as => :videos

  # this may change as development changes
  # removing my version for solution version
  # get '/video' => 'videos#show'
  # resources :videos, only: [:show, :index]

  resources :videos, only: [:show] do
    collection do
      post :search, to: 'videos#search'
    end
  end
  # not shown in solution
  # get '/genre' => 'categories#show', :as => :categories
  resources :categories, only: [:show]
  get 'ui(/:action)', controller: 'ui'
end
