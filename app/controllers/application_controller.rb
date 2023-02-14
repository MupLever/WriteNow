# frozen_string_literal: true

class ApplicationController < ActionController::Base
  rescue_from ActiveRecord::RecordNotFound, with: :founderror

  private

  def founderror(exception)
    logger.warn exception
    render file: 'public/404.html', status: :not_found, layout: false
  end

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id].present?
  end

  def signed_in?
    current_user.present?
  end

  def no_signed_in?
    !current_user.present?
  end

  def sign_out
    session.delete :user_id
  end

  def no_authentication
    return if no_signed_in?

    redirect_to root_path
  end

  def authentication
    return if signed_in?

    redirect_to root_path
  end

  helper_method :current_user, :signed_in?
  helper_method :current_user, :no_signed_in?
end
