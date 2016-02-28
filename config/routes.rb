Myflix::Application.routes.draw do
  root to: "ui#index"

  get '/:action', controller: 'ui'
end
