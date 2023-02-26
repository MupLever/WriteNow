# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :no_authentication, only: %i[new create]
  before_action :authentication, only: %i[show edit update like]
  before_action :receive_before, only: %i[edit update show]
  before_action :authorization, only: %i[update edit]

  def new
    @user = User.new
  end

  def create
    @user = User.new receive_params_for_new
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      redirect_to new_user_path
      flash[:danger] = 'An error has occurred, perhaps a user with such an email is already registered'
    end
  end

  def update
    if @user.update receive_params_for_update
      redirect_to root_path
      flash[:success] = 'You have successfully edited profile.'
    else
      render :edit
    end
  end

  def edit; end

  def show; end

  def index
    @users = User.all.reject { |user| current_user&.likes&.include?(user.id) }
  end

  def like
    current_user.like(User.find receive_liked_user_id)
    redirect_to users_path
  end

  def receive_before
    @user = User.find params[:id]
  end

  def receive_params_for_new
    params.require(:user).permit(:email, :name, :surname, :password, :password_confirmation)
  end

  def receive_params_for_update
    params.require(:user).permit(:email, :name, :surname, :information)
  end

  def receive_liked_user_id
    params[:id].to_i
  end

  def authorization
    return if current_user == @user

    flash[:warning] = 'you can\'t edit other users'
    redirect_to root_path
  end
end
