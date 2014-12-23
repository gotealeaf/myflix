class SessionsController < ApplicationController
  
  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:notice] = 'Welcome, you have logged in!'
      redirect_to home_path
    else
      flash[:error] = 'Username or password does not match.'
      redirect_to login_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = 'You have logged out.'
    redirect_to root_path
  end
end