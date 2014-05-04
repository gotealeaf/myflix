class ForgotPasswordsController < ApplicationController
  def create
    if @user = User.find_by_email(params[:email])
      @user.generate_password_token
      AppMailer.reset_password_email(@user).deliver
    else
      flash[:warning] = 'Your email address is not recognized.'
      redirect_to forgot_password_path
    end
  end
end