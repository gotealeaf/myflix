class ApplicationController < ActionController::Base
  protect_from_forgery

  def authorize
    if current_user.nil?
      flash[:info] = 'You must sign in first, thank you.'
      redirect_to sign_in_url
    end
  end

  private

  def current_user
    @current_user ||= User.where(auth_token:session[:auth_token]).first
  end
  helper_method :current_user
end
