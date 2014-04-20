class SessionsController < ApplicationController
  
  def new
    user = User.new
  end
  
  def create
    user = User.find(params[:id])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = "You have successfully logged in."
      redirect_to root_path
    else
      flash[:error] = "There is something wrong with your email or password."
      redirect_to root_path
    end
  end
  
  def delete
    session[:user_id] = nil
    flash[:notice] = "You have been signed out."
  end
  
end