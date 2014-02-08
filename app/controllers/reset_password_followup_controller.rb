class ResetPasswordFollowupController < ApplicationController

  def show
    user = User.where(token: params[:id]).first
    if user
      @token = user.token
    else
      redirect_to password_followup_expired_path
    end
  end

  def create
    user = User.where(token: params[:token]).first
    if user
      user.password = params[:password]
      user.generate_token
      user.save
      flash[:notice] = "Your password has been saved."
      redirect_to sign_in_path
    else
      redirect_to password_followup_expired_path
    end
  end
end