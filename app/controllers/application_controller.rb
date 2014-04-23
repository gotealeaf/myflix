class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end
  
  def require_user
    unless logged_in?
          flash[:warning] = "You must be logged in to do that."
      redirect_to sign_in_path
    end
  #  redirect_to sign_in_path unless logged_in?
  end

  def require_sign_out
    redirect_to home_path if current_user
  end
end
