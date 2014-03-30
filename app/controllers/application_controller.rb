class ApplicationController < ActionController::Base
  protect_from_forgery

  helper_method :signed_in?, :signed_out?, :current_user


  def signin_user(user)
    session[:user_id] = user.id
    flash[:notice] ||= "Welcome, #{user.name}!"
    redirect_to root_path
  end

  def current_user
    User.find(session[:user_id]) if signed_in?
  end

  def access_denied(msg)
    flash[:notice] = msg
    redirect_to root_path
  end

  def signed_in?
    !!session[:user_id]
  end

  def signed_out?
    !!session[:user_id].nil?
  end

  def require_signed_in
      unless signed_in?
        access_denied("Please sign-in to do that.")
      end
  end

  def require_signed_out
      unless signed_out?
        access_denied("You're already signed in.")
      end
  end

  def require_owner
    User.find(params[:id]) == current_user if signed_in?
  end
end
