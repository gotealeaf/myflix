Myflix::Application.routes.draw do
  get "categories/show"
  get "videos/show"
  get "homes/home"
  get 'ui(/:action)', controller: 'ui'
  get 'home' => "homes#home"
  resources :videos,only: [:show]
  get '/video', to: "videos#show"
  resources :categories,only: [:show]
end
