Myflix::Application.routes.draw do
  get 'home', to: 'ui#home'
  get 'ui(/:action)', controller: 'ui'
end
