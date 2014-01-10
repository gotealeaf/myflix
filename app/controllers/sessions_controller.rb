class SessionsController < ApplicationController
  def new
    redirect_to home_path if current_user
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You are signed in!'
      redirect_to home_path
    else
      flash[:danger] = "Invalid email or password. Please try again."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You have been signed out succesfully."
    redirect_to root_path 
  end
end