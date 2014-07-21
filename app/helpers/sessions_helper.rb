module SessionsHelper

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_user?(user)
    current_user == user
  end

  def signed_in?
    !!current_user
  end

  def signed_in_user
    unless signed_in?
      flash[:warning] = "You must sign in"
      redirect_to root_path
    end
  end
end
