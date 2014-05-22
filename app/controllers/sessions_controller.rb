class SessionsController < ApplicationController
  def new
    redirect_to home_path if current_user
  end
  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to home_path
      flash[:success] = "You are signed in, enjoy!"
    else
      flash[:danger] = "Oh snap! Change a few things up and try submitting again."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
    flash[:success] = "You are signed out."
  end
end