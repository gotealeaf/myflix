class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.where(email: params[:user][:email]).first
    user = @user
    if user && user.authenticate(params[:user][:password])
      flash[:error] = 'This is a testing error message'
      session[:user_id] = user.id
      redirect_to home_path
    else
      flash[:error] = "Your login did not authenticate."
      render :new
    end
  end

  def logout
    session[:user_id] = nil
    redirect_to root_path
  end
end
