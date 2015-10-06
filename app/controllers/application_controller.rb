class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find session[:id] if session[:id] 
  end

  def logged_in?
    !!current_user
  end

  def require_login
    access_denied unless logged_in?
  end

  def access_denied
    flash[:warning] = "sorry, your access is denied"
    redirect_to sign_in_path
  end

end
