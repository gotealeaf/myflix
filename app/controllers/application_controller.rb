class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :logged_in?, :current_user
  
  def current_user
    @current_user ||=User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    !!current_user
  end
  
  def require_user 
    if !current_user
    access_denied
    redirect_to root_path
    end
  end
  
  def access_denied
    flash[:danger] = "You must be logged in to do that."
  end
  
end
