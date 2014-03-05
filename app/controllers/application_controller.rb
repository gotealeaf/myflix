class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  helper_method :logged_in?, :current_user, :require_user

  def current_user
    # Memoized so it only hits the database once if a template calls a bunch of times
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    unless logged_in?
      flash[:danger] = "You must be logged in to do that."
      redirect_to root_path
    end
  end
end
