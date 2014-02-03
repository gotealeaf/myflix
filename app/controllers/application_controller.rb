class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_user
    redirect_to sign_in_path unless current_user
  end

  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end

  # this allows current_user to be called in the views
  helper_method :current_user
end
