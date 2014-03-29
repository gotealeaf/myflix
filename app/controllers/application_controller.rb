class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :current_user, :authorize

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
    rescue ActiveRecord::RecordNotFound
  end

  def authorize
    redirect_to sign_in_path, alert: "Not authortized" unless current_user
  end
end
