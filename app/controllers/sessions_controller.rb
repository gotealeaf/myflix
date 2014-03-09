class SessionsController < ApplicationController

  def new
    redirect_to home_path if current_user
  end

  def create
    
    user = User.find_by(email: params[:email])
    
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = "You are logged in"
      redirect_to home_path
    else
      flash[:danger] = "There is something wrong with your email or password"
      render :new
    end



  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You are signed out."
  end
end
