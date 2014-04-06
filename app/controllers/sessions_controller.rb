class SessionsController < ApplicationController
  def new
    redirect_to videos_path if current_user
  end

  def create
    binding.pry
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to videos_path, notice: "Logged in!"
    else
      flash[:notice] = "Email or password is invalid"
      render "new"
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, notice: "Logged out!"
  end

  def forgot_password
  end

  def send_token
    @user = User.find_by_email(params[:email])
    AppMailer.password_reset(@user).deliver
    redirect_to confirm_password_path
  end

  def confirm_password
  end 

  def reset_password
  end

  def update_password
    @user = User.find_by_token(params[:id])
    @user.update(params[:password])
    redirect_to sign_in_path
  end
end