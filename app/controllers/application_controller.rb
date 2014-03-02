class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :authorize

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def authorize
    redirect_to sign_in_path, alert: "Not authortized" if current_user.nil?
  end
end
