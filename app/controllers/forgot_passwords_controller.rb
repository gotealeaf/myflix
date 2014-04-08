class ForgotPasswordsController < ApplicationController
  def email_page
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      AppMailer.password_reset(@user).deliver
      redirect_to confirm_password_reset_path
    else
      flash[:notice] = "Unknown user email"
      render "email_page"
    end
  end

  def confirm_password_reset
  end
end