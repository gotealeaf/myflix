Myflix::Application.routes.draw do
  get 'ui/home', to: "ui#home"
  get 'ui/genre', to: "ui#genre"
  get 'ui(/:action)', controller: 'ui'

end
