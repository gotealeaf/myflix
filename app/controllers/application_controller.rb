class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :require_user

  def current_user # make sure this is the same as Controller
    @current_user ||= User.find_by(username: session[:username]) if session[:username]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    # To do
  end
end
