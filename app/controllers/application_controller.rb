class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :signed_in?

  def signed_in?
    current_user.present?
  end

  def current_user
    return unless session[:user_id].present?
    @current_user ||= User.where(id: session[:user_id]).first
  end

  def user_required!
    redirect_to sign_in_path unless signed_in?
  end
end
