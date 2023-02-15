# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :no_authentication, only: %i[new create]
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
    @users = User.all.reject { |user| user.id == current_user.id }
  end

  def update
    liked_user_id = recieve_params_for_update
    likes = current_user.likes.to_a

    unless likes.include?(liked_user_id)

      likes << liked_user_id
      current_user.update_column(:likes, likes)

      if User.find(liked_user_id).likes.include?(current_user.id)
        match = Match.new(users: [liked_user_id, current_user.id])
        redirect_to match_path if match.save
      end
      
    end
  end

  def recieve_params_for_new
    params.require(:user).permit(:email, :name, :surname, :password, :password_confirmation)
  end

  def recieve_params_for_update
    Integer(params[:user_id])
  end

  def before_recieve
    @user = User.find params[:id]
  end
end
