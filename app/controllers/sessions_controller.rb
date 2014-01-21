class SessionsController < ApplicationController
  def new
    redirect_to videos_path if current_user
  end

  def create
    user = User.where(email: params[:email]).first
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome, #{user.full_name}, you are now logged in."
    else
      flash[:error] = "Invalid email or password."
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are now signed out."
  end
end