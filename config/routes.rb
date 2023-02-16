Rails.application.routes.draw do

  resource :session, only: [:new, :create, :destroy]
  resources :users, only: [:new, :create, :show, :index, :update]
  resources :matches, only: [:create, :destroy, :show, :index]

  resources :matches do
    resources :messages, only: [:create, :destroy] 
  end
  post "users/:id/like", to: "users#like", as: "like_user"
  root 'users#index'
end
