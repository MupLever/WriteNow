# frozen_string_literal: true

class SessionsController < ApplicationController
  before_action :no_authentication, only: %i[new create]
  def new; end

  def create
    user = User.find_by email: params[:email]
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You have successfully logged in.\nWelcome to the gym, #{user.name}!"
      redirect_to root_path
    else
      flash[:warning] = 'Data entered incorrectly'
      redirect_to new_session_path
    end
  end

  def destroy
    sign_out
    flash[:success] = 'You have successfully logged out.\nGet back to the gym soon!'
    redirect_to root_path
  end
end
