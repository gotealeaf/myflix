class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:warning] = "Access reserved for members only. Please sign in first."
      redirect_to login_path
    end
  end

  def require_admin
    if logged_in? && !current_user.admin?
      flash[:danger] = "You don't have authority to do that!"
      redirect_to home_path
    end
  end
end
