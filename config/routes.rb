Myflix::Application.routes.draw do
root to: 'videos#index'
get '/video', to: 'videos#show'


resources :videos

end
