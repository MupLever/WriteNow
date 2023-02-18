Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :update, :edit, :show, :index]
  resources :matches, only: [:create, :destroy, :show, :index]

  resources :matches do
    resources :messages, only: [:create, :destroy] 
  end

  # post "users/:id/edit", to: "users#update"
  post "users/:id/like", to: "users#like", as: "like_user"
  root 'users#index'
end
