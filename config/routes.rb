Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui' 
 # get 'videos/:action', controller: 'videos'
    resources :videos, only: [:index, :show] do
    resources :categories, only: [:show] do
   end
   end  
 end
 
