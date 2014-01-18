class SessionsController < ApplicationController
  
  def new
    @user = User.new    
    redirect_to home_path if current_user
  end

  def create
    user = User.find_by(email: params[:user][:email])
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to home_path, notice: 'you are signed in!'
    else
      flash[:danger] = 'invalid email or password'
      redirect_to sign_in_path
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: 'you are signed out'
  end

end
