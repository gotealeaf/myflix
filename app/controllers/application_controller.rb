class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :require_user, :require_admin

  def current_user # make sure this is the same as Controller
    @current_user ||= User.find_by(username: session[:username]) if session[:username]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:danger] = "Please sign in."
      redirect_to sign_in_path
    end
  end

  def require_admin
    redirect_to home_path unless current_user.admin?
  end
end
