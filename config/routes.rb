Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui' 
 # get 'videos/:action', controller: 'videos'
    resources :videos, only: [:index, :show] do
     collection do
      post :search, to: "videos#search"
     end
    resources :categories, only: [:show] 
   end  
 end
 
