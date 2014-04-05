class SessionsController < ApplicationController
  def new
    redirect_to videos_path if current_user
  end

  def create
    user = User.find_by(email: params[:email]) 
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to videos_path, notice: "You are logged in."
    else 
      flash[:error] = "email and/or password are not correct."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are signed out."
  end

end