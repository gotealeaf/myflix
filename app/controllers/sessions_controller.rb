class SessionsController < ApplicationController
  
  def new
    redirect_to home_path if current_user    
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are now logged in!"
      redirect_to home_path
    else
      redirect_to sign_in_path, flash: { danger: "Invalid email or password." }
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:warning] = "You have successfully logged out."
    redirect_to root_path, flash: { warning: "You have successfully logged out." }
  end
end