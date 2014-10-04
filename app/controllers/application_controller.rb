class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?

  def require_user
  	redirect_to root_path unless logged_in?
  end

  def current_user
  	current_user = User.find_by id: session[:user_id]
  end

  def logged_in?
  	!!current_user
  end

end
