# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :no_authentication, only: %i[new create]
  def new
    @user = User.new
  end

  def create
    @user = User.new recieve_params
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path
    else
      render :new
    end
  end

  def recieve_params
    params.require(:user).permit(:email, :name, :surname, :password, :password_confirmation)
  end
end
