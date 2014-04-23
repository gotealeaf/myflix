class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    setup_user
    if authenticate_user
      flash[:success] = 'You are now logged in.'
      session[:user_id] = @user.id
      redirect_to home_path
    else
      flash[:danger] = "Your login did not authenticate."
      render :new
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end

  private

  def authenticate_user
    @user && @user.authenticate(params[:user][:password])
  end

  def setup_user
    @user = User.where(email: params[:user][:email]).first
  end
end
