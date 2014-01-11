class SessionsController < ApplicationController
  def new
    @user = User.new
    redirect_to videos_path if current_user
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to root_path, notice: "Welcome, #{user.full_name}, you are now logged in."
    else
      flash[:error] = "Invalid email or password."
      @user = User.new
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are now signed out."
  end
end