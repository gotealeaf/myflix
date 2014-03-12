class SessionsController < ApplicationController
  def new
    redirect_to home_path if signed_in?
  end

  def create
    email, password = params[:email], params[:password]
    user = User.where(email: email).first

    if user && user.authenticate(password)
      session[:user_id] = user.id
      redirect_to home_path, notice: "You are signed in, enjoy!"
    else
      flash[:error] = "Invalid email or password"
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    @current_user = nil
    redirect_to root_path, notice: "You are signed out"
  end
end
