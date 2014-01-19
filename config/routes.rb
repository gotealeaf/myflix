Myflix::Application.routes.draw do

	get 'ui/genre(/:action)', controller: 'genre'
  get 'ui/video(/:action)', controller: 'video'
  get 'ui/home(/:action)', controller: 'home'
  get 'ui(/:action)', controller: 'ui'
end
