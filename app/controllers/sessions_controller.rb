class SessionsController < ApplicationController
  def new
    redirect_to home_path if logged_in?
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      flash[:success] = 'You were logged in successfully'
      redirect_to home_path
    else
      flash.now[:danger] = 'Incorrect email address or password.  Please try again.'
      render :new
    end
  end

  def destroy
    session[:user_id] = nil
    flash[:info] = 'You have successfully logged out.'
    redirect_to root_path
  end
end
