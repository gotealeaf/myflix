class PasswordResetsController < ApplicationController
  def show
    @user = User.find_by_token(params[:id])
    if !@user
      redirect_to expired_token_path
    elsif has_reset_password_url_passed? @user
      redirect_to expired_token_path
    end
  end

  def create
    user = User.find_by_token(params[:token])
    if user
      if params[:password] == params[:password_confirmation]
        user.reset_passsword params[:password]
        flash[:notice] = "You have successfully changes your password"
        redirect_to sign_in_path
      else
        flash[:error] = "Password and Password confirmation do not match."
        redirect_to password_reset_path(id: params[:token])
      end
    else
      redirect_to expired_token_path
    end    
  end

  def has_reset_password_url_passed? user
    @user.reset_password_email_sent_at.to_i + 1.day.to_i >= Time.now.to_i
  end
end
