Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui' 
  get 'videos/:action', controller: 'videos'
end
 
