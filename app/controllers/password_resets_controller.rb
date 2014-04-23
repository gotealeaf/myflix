class PasswordResetsController < ApplicationController
  def create
    if params[:user][:email] != ""
      set_user
      if @user
        reset_password
      end
      redirect_to reset_request_confirmation_path
    else
      flash[:danger] = "You must enter a valid email."
      redirect_to reset_password_path
    end

  end

  def update
    if params[:user][:password] == ""
      flash[:danger] = "Your password cannot be blank."
      render :edit
    else
      save_new_password
      flash[:success] = "Your password has been updated."
      redirect_to login_path
    end
  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by_reset_token!(params[:id])
  end

  private

  def save_new_password
    @user = User.find_by_reset_token!(params[:token])
    @user.update_attributes(password: params[:user][:password], reset_token: nil)
    @user.save
  end

  def reset_password
    @user.generate_token(:reset_token)
    if @user.save
      UserMailer.delay.password_reset_email(@user)
    end
  end

  def set_user
    @user = User.find_by_email(params[:user][:email])
  end

  def find_user_by_token
    User.find_by_reset_token!(params[:reset_token])
  end
end
