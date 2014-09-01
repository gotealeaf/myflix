class SessionsController < ApplicationController

  def new
    redirect_to home_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      if user.active?
        session[:username] = user.username
        flash[:success] = "Welcome #{ user.username }"
        redirect_to home_path
      else
        flash[:danger] = "Your account has been suspended."
        redirect_to sign_in_path
      end
    else
      flash.now[:danger] = "Incorrect email or password. Please try again."
      render :new
    end
  end

  def destroy
    session[:username] = nil
    flash[:success] = "You have signed out."
    redirect_to :root
  end

end
