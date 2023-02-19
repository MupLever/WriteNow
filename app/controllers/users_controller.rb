# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :no_authentication, only: %i[new create]
  before_action :authentication, only: %i[show edit update like]
  before_action :receive_before, only: %i[edit update show]
  before_action :it_possible_to_edit, only: :update

  def new
    @user = User.new
  end

  def create
    @user = User.new receive_params_for_new
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
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
    @users = User.all.to_a.reject { |user| current_user&.likes&.include?(user.id) }
  end

  def like
    liked_user_id = receive_params_for_like
    likes = current_user.likes

    return if likes.include?(liked_user_id)

    likes << liked_user_id
    current_user.update(likes: likes)
    liked_user = User.find(liked_user_id)

    if liked_user.likes.include?(current_user.id)
      Match.create(users: [current_user, liked_user])
      redirect_to matches_path
    else
      redirect_to users_path
    end
  end

  def receive_before
    @user = User.find params[:id]
  end

  def receive_params_for_new
    params.require(:user).permit(:email, :name, :surname, :password, :password_confirmation)
  end

  def receive_params_for_update
    params.require(:user).permit(:email, :name, :surname, :information, :password, :password_confirmation)
  end

  def receive_params_for_like
    params[:id].to_i
  end

  def it_possible_to_edit
    return if current_user == @user

    flash[:warning] = 'you can\'t edit other users'
    redirect_to root_path
  end
end
