class SessionsController < ApplicationController
  def new
    redirect_to home_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:info] = "Access granted!"
      redirect_to home_path
    else
      flash[:warning] = "Your email or password do not match."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = "You are logged out."

    redirect_to root_path
  end
end