class PasswordResetsController < ApplicationController
  def create
    user = User.find_by_email(params[:user][:email])
    if user
      user.reset_token = user.generate_token(user.reset_token)
      if user.save
        UserMailer.password_reset_email(user).deliver
      end
    end
    redirect_to reset_request_confirmation_path
  end

  def update
    binding.pry
    user = User.find_by_reset_token!(params[:id])

  end

  def new
    @user = User.new
  end

  def edit
    @user = User.find_by_reset_token!(params[:id])
  end
end
