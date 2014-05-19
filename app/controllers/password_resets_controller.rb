class PasswordResetsController < ApplicationController
  
  def show
    user = User.where(token: params[:id]).first
    if user
      @token = user.token
    else
      redirect_to invalid_token_path 
    end
  end
  
  def create
    user = User.where(token: params[:token]).first
    if user
      user.password = params[:password]
      user.generate_token #using the User model method
      user.save
      flash[:success] = "Your password was successfully changed."
      redirect_to login_path
    else
      flash[:danger] = "Your password token is invalid."
      redirect_to invalid_token_path
    end
  end
  
end