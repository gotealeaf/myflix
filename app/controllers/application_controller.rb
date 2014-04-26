class ApplicationController < ActionController::Base
  protect_from_forgery

  def require_user
    unless current_user
      flash[:error] = "You must be logged in to do that."
      redirect_to sign_in_path 
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
end
