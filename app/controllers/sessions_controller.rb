class SessionsController < ApplicationController
  before_action :require_user, only: [:destroy]
  before_action :can_sign_in?, only: [:new]

  def new; end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "Welcome #{user.name}!! You successfully signed in."
      redirect_to home_path      
    else
      flash[:danger] = "Invalid email or password. Please try again."
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = "You've logged out."
    redirect_to root_path 
  end

  private 

  def can_sign_in?  
    if logged_in?
      flash[:danger] = "You are already signed-in."
      redirect_to home_path
    end
  end
end