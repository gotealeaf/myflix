class ForgotPasswordController < ApplicationController
  
  def create
    @user = User.find_by(email: params[:email])
    if @user
      UserMailer.send_password_reset(@user).deliver
      render :confirm_password_reset
    else
      flash[:warning] = params[:email].blank? ? "Email cannot be blank.": "Invalid email address."
      redirect_to forgot_password_path
    end
  end
end
