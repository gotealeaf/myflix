class SessionsController < ApplicationController
  
  def new
    #user = User.new
    redirect_to home_path if current_user
  end
  
  def create
    user = User.where(email: params[:email]).first
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are signed in, enjoy your movies!"
      redirect_to home_path 
    else
      flash[:danger] = "There is something wrong with your email or password."
      redirect_to login_path
    end
  end
  
  def destroy
    session[:user_id] = nil
    flash[:danger] = "You have been signed out."
    redirect_to root_path
  end
  
end