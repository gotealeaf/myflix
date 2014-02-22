Myflix::Application.routes.draw do
  get 'ui(/:action)', controller: 'ui'

  #get '/home', to: 'videos#home'
  #get '/video/:id', to: 'videos#video'
  
	#get '/comedies', to: 'categories#comedy'
	#get '/dramas', to: 'categories#drama'
	#get '/realities', to: 'categories#reality'  


  resources :videos	
  resources :categories




end
