class SessionsController < ApplicationController
  
  def new
    redirect_to home_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password])
      login_user(user)
    else
      flash[:error] = "Your username and/or password are incorrect"
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:notice] = "You've logged out."
    redirect_to root_path
  end

  private

  def login_user(user)
    session[:user_id] = user.id
    flash[:notice] = "Welcome, you've logged in!"
    redirect_to home_path
  end
end