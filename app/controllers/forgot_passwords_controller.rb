class ForgotPasswordsController < ApplicationController
  def create
    if @user = User.find_by_email(params[:email])
      @user.generate_password_token
      UserMailer.reset_password_email(@user).deliver
    else
      flash[:warning] = 'Your email address is not recognized.'
      redirect_to forgot_password_path
    end
  end

  def edit
    unless @user = User.find_by_password_token(params[:password_token])
      flash[:warning] = 'Invalid Page'
      redirect_to sign_in_path  
    end
  end

  def update
    if @user = User.find_by_password_token(params[:password_token])
      update_password_and_remove_token(@user)
      flash[:success] = 'Your password has been reset. Please log in.'
    else
      flash[:warning] = 'Invalid Page'
    end

    redirect_to sign_in_path
  end

  private

  def update_password_and_remove_token(user)
    user.update(password: params[:password], password_confirmation: params[:password_confirmation])
    user.update(password_token: nil)
  end
end