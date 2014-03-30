class SessionsController < ApplicationController
  before_action :require_signed_out, only: [:new, :create]
  before_action :require_signed_in,  only: [:destroy]

  def new
  end

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      signin_user(@user)
    else
      flash.now[:error] = "Username or Password Incorrect. Please try again."
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path, notice: "You're now signed out."
  end
end
