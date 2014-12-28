class ApplicationController < ActionController::Base
  protect_from_forgery 

  helper_method :current_user, :logged_in?, :this_year
  def current_user
    user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def this_year
    @year = Date.today.year
  end

end
