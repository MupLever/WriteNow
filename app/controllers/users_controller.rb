# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :no_authentication, only: %i[new create]
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
    p recieve_params_for_update
    likes = current_user.likes ? likes : []
    likes << recieve_params_for_update
    if current_user.update_column(:likes, likes)
      flash[:success] = 'Our question was successfully updated'
    end
  end

  def recieve_params_for_new
    params.require(:user).permit(:email, :name, :surname, :password, :password_confirmation)
  end

  def recieve_params_for_update
    Integer(params[:user_id])
  end
end
