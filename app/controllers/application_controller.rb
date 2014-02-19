class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :logged_in?, :require_user, :display_message_for_access_denied

  def current_user
    binding.pry
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def logged_in?
    !!current_user
  end

  def require_user
    if !logged_in?
      access_denied
    end
  end

  def access_denied
    display_message_for_access_denied
    if !logged_in?
      redirect_to login_path
    else
      redirect_to home_path
    end
  end

  def display_message_for_access_denied
    flash[:danger] = 'Sorry, you cannot perform this action.'
  end
end
