class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?
  
  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_user
    unless current_user
      flash[:error] = "Access is reserved for members only. Please sign in first."
      redirect_to login_path 
    end
  end

  def logged_in?
    !!current_user
  end

end
