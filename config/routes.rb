Myflix::Application.routes.draw do
  require 'sidekiq/web'

  get 'ui(/:action)',         controller: 'ui'

  root                        to: 'pages#front'
  get     '/home',            to: 'categories#index'
  get     '/register',        to: 'users#new'
  get     '/invite',          to: 'invitations#new'
  get     '/signin',          to: 'sessions#new'
  get     '/signout',         to: 'sessions#destroy'
  post    '/follow',          to: 'relationships#create'
  get     '/people',          to: 'relationships#index'
  delete  '/unfollow',        to: 'relationships#destroy'
  get     '/my_queue',        to: 'queue_items#index'
  post    '/update_queue',    to: 'queue_items#update_queue'
  get     'expired_token',    to: 'password_resets#expired_token'
  get     '/forgot_password', to: 'forgot_passwords#new'
  get     '/confirm_password_reset_email', to:'forgot_passwords#confirm_password_reset_email'
  get     '/register/:token', to: 'users#new_with_token', as: 'register_with_token'

  resources :invitations,     only: [:create]
  resources :password_resets, only: [:show, :create]
  resources :forgot_passwords,only: [:create]
  resources :categories,      only: [:show]
  resources :queue_items,     only: [:create, :destroy]
  resources :sessions,        only: [:create]
  resources :users,           only: [:create, :show]
  resources :videos,          only: [:show] do
    collection do
      get  :search  #videos/search
    end
    resources :reviews,       only: [:create]
  end


  namespace :admin do
    resources :videos,        only: [:new]
  end


  mount Sidekiq::Web, at: '/sidekiq'
end
