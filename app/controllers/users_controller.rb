class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
    
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      AppMailer.send_welcome_email(@user).deliver
      redirect_to sign_in_path
    else
      flash[:error] = "User couldn't be created. #{@user.errors.full_messages.first}"
      render :new
    end
  end

  def show
    @user = User.find_by_token(params[:id])
  end

  def forgot_password
     user = User.find_by_email(params[:email])
    if user
      message = AppMailer.send_forgot_password_email(user).deliver 
      set_reset_password_email_at user
      redirect_to sign_in_path
    else
      flash[:error] = "There is no user account registered with this email, please type it again or register if you have not done it yet."
    end   
  end

  def reset_password
    
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name, :password_confirmation)
  end

  def set_reset_password_email_at user
    message = ActionMailer::Base.deliveries.last
    if message
      user.reset_password_email_sent_at = message.date 
      user.save(:validate => false)
    end
  end
end