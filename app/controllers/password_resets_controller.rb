class PasswordResetsController < ApplicationController
  def show
    @user = User.find_by_token(params[:id])
    redirect_to expired_token_path unless @user
    @token
  end

  def create
    user = User.find_by_token(params[:token])
    # binding.pry
    if user
      user.password = params[:password]
      user.password_confirmation = params[:password]
      user.generate_token
      user.save
      flash[:notice] = "You have successfully changes your password"
      redirect_to sign_in_path
    else
      redirect_to expired_token_path
    end    
  end
end
