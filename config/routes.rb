Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'
  get '/home', to: 'videos#index' 
  get '/videos/show', to: 'videos#show'
  get '/genre', to: 'categories#show'
end
