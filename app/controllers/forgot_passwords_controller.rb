class ForgotPasswordsController < ApplicationController

  def create
    user = User.where(email: params[:email]).first
    if user
      AppMailer.send_password_reset_email(user).deliver
      redirect_to forgot_password_confirmation_path
    else
      flash[:error] = "We couldn't find that email in the system."
      redirect_to forgot_password_path
    end    
  end

  def show
    user = User.where(token: params[:id]).first unless params[:id] == nil
    if user
      @token = user.token
      render :show
    else
      redirect_to expired_token_path
    end
  end

  def reset
    user = User.where(token: params[:token]).first unless params[:token] == nil
    if user
      if (params[:password] == params[:password_confirmation]) && (params[:password].length > 5)
        user.password = params[:password]
        user.password_confirmation = params[:password_confirmation]
        user.token = nil
        user.save
        flash[:success] = "Your password has been changed. You can now log in with your new password."
        redirect_to sign_in_path
      else
        flash[:error] = "Password must match and be at least 6 characters!"
        redirect_to :back
      end
    else
      redirect_to expired_token_path
    end
  end
end