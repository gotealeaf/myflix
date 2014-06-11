Myflix::Application.routes.draw do
  root to: 'ui#index'
  get 'ui(/:action)', controller: 'ui'
end
