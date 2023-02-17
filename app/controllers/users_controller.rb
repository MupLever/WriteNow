# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :no_authentication, only: %i[new create]
  before_action :authentication, only: %i[show edit update like]
  before_action :before_recieve, only: %i[show]

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

  def update
    p "*" * 80
    pp recieve_params_for_update
    p "*" * 80
    if current_user.update recieve_params_for_update
      redirect_to root_path
    else
      render :edit
    end
  end

  def edit; end

  def show; end

  def index
    @users = User.all.to_a.reject { |elem| current_user&.likes&.include?(elem.id) } 
  end

  def like
    liked_user_id = recieve_params_for_like
    likes = current_user.likes

    unless likes.include?(liked_user_id)

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
  end

  def recieve_params_for_new
    params.require(:user).permit(:email, :name, :surname, :password, :password_confirmation)
  end

  def recieve_params_for_update
    {email: params[:email], name: params[:name], surname: params[:surname], information: params[:information], password: params[:password], password_confirmation: params[:password_confirmation]}
  end

  def recieve_params_for_like
    params[:id].to_i
  end

  def before_recieve
    @user = User.find params[:id]
  end
end
