Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :index, :update]
  resources :matches, only: [:create, :destroy, :show, :index] 

  post "users/:id/like", to: "users#like", as: "like_user"
  root 'main#index'
end
