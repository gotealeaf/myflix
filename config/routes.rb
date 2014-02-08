Myflix::Application.routes.draw do
  get '/home', to: 'ui#home'
  get '/video', to: 'ui#video'
  get '/genre/:id', to: 'ui#genre'

  get 'ui(/:action)', controller: 'ui'
end
