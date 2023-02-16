# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :no_authentication, only: %i[new create]
  before_action :authentication, only: %i[show update]
  before_action :before_recieve, only: %i[show update]
  def new
    @user = User.new
  end

  def create
    @user = User.new recieve_params_for_new
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def show; end

  def index
    @users = User.all
  end


  def like
    p "*" * 90
    liked_user_id = recieve_params_for_update
    likes = current_user.likes

    unless likes.include?(liked_user_id)

      likes << liked_user_id
      current_user.update(likes: likes)
      liked_user = User.find(liked_user_id)

      if liked_user.likes.include?(current_user.id)
        Match.create(users: [current_user, liked_user])
        redirect_to matches_path
      end
      
    end
  end

  def update
    
  end

  def recieve_params_for_new
    params.require(:user).permit(:email, :name, :surname, :password, :password_confirmation)
  end

  def recieve_params_for_update
    params[:id].to_i
  end

  def before_recieve
    @user = User.find params[:id]
  end
end
