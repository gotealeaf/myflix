class SessionsController < ApplicationController

  def new 
    redirect_to home_path if current_user
  end

  def create
    user = User.find_by(email: params[:email])
    if user && user.authenticate(params[:password]) #given by has_secure_password
      session[:user_id] = user.id
      flash[:info] = 'You have sucessfully login'
      redirect_to home_path
    else
      flash[:danger] = 'There is something wrong in password or email'
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = 'You have lsigned out. '
    redirect_to root_path
  end
  
end