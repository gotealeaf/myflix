Myflix::Application.routes.draw do

  resources :videos, only: :show do
    collection do
      post 'search'
    end

    resources :reviews, only: :create
  end

  resources :categories, only: :show

  get 'sign_in', to: 'sessions#new'
  post 'sign_in', to: 'sessions#create'
  get 'sign_out', to: 'sessions#destroy'
  get 'register', to: 'users#new'
  post 'register', to: 'users#create'

  resources :users, only: [:show, :edit, :update], path: '/account'
  get 'forgot_password', to: 'users#forgot_password'
  post 'forgot_password', to: 'users#forgot_password'
  get 'confirm_password_reset', to: 'pages#confirm_password_reset'
  get 'reset_password/:token', to: 'users#reset_password', as: 'reset_password'
  post 'reset_password/:token', to: 'users#reset_password'
  get 'invalid_password_reset_token', to: 'pages#invalid_password_reset_token'

  get :people, to: 'relationships#index'
  resources :relationships, only: [:create, :destroy]

  post 'update_queue', to: 'queue_items#update_queue'

  resources :queue_items, only: [:create, :destroy, :index], path: '/my_queue'

  root to: 'pages#front'
  get 'ui(/:action)', controller: 'ui'
  get 'home', to: 'videos#index'
end
