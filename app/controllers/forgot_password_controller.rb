class ForgotPasswordController < ApplicationController

  def create
    @user = User.find_by(email: params[:email])
    if @user
      UserMailer.send_password_reset(@user).deliver
      render :confirm_password_reset
    elsif params[:email].blank?
      flash[:warning] = "Email cannot be blank."
      redirect_to forgot_password_path
    end
  end
end
