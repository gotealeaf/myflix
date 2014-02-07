class UsersController < ApplicationController
  before_action :require_user, only: :show

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session[:user_id] = @user.id
      AppMailer.welcome_email(@user).deliver
      flash[:success] = 'Account created successfully, you have been logged in.'
      redirect_to home_path
    else
      render :new
    end
  end

  def forgot_password
    if params[:email_address].blank?
      render :forgot_password
    else
      user = User.find_by(email: params[:email_address])

      if user
        user.generate_password_reset_token
        AppMailer.send_password_reset_email(user).deliver
      end

      redirect_to confirm_password_reset_path
    end
  end

  def reset_password
    if request.post?
      user = User.find_by(password_reset_token: params[:token])
      user.password = params[:password]
      user.password_reset_token = nil

      if user.save
        flash[:success] = 'Your password was changed successfully. You may now log in.'
        redirect_to sign_in_path
      else
        flash[:danger] = 'There was a problem resetting your password.'
      end
    end
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password)
  end
end
