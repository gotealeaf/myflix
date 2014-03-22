class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :logged_in?, :current_user

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to do that."
      redirect_to root_path
    end
  end

  def require_no_user
    if logged_in?
      flash[:danger] = "You can't do that. You're already logged in."
      redirect_to home_path
    end
  end
end
