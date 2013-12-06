Myflix::Application.routes.draw do
   root to: 'videos#index'

   resource :videos, except: [:destroy]
end
 
