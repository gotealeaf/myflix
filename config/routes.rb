Myflix::Application.routes.draw do
  get 'home', controller: 'ui'
  get 'ui(/:action)', controller: 'ui'
end
