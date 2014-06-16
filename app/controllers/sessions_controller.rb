class SessionsController < ApplicationController
  def new
    binding.pry
    redirect_to home_path if current_user
  end

  def create
    user = User.where(email:params[:email]).first
    if user && user.authenticate(params[:password])
      cookies[:auth_token] = user.auth_token
      flash[:success] = 'Signed in successfully.'
      redirect_to home_path
    else
      flash.now[:danger] = "Incorrect email or password."
      render :new
    end
  end

  def destroy
    current_user.new_auth_token if current_user
    cookies.delete(:auth_token)
    flash[:info] = 'Signed out, see you again soon.'
    redirect_to root_path
  end
end
