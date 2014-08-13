class ApplicationController < ActionController::Base
  protect_from_forgery

  def logged_in?
    return true if current_user
    redirect_to sign_in_path
  end

  def current_user
    if session[:user_id].present?
      User.find_by_id(session[:user_id])
    else
      nil
    end
  end

  helper_method :current_user
end
