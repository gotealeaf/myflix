class SessionsController < ApplicationController
  def new
    redirect_to home_path if logged_in?
  end

  def create
    @user = User.find_by(email: params[:email])

    if @user && @user.authenticate(params[:password])
      if @user.active?
        session[:user_id] = @user.id
        flash[:info] = "Welcome, you've logged in."
        redirect_to home_path
      else
        flash[:danger] = "Your account has been suspend, please contact customer service!"
        redirect_to login_path
      end
    else
      flash[:warning] = 'There is something wrong with your email or password.'
      redirect_to login_path
    end
  end

  def destroy
    flash[:info] = "You've logged out."
    session[:user_id] = nil
    redirect_to root_path
  end

end
