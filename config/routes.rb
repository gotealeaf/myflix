Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  get 'home', to: 'video#home'
end
