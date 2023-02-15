Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :index, :update]
  resources :matches, only: [:new, :create, :destroy, :show, :index] 

  root 'main#index'
end
