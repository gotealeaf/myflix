class PasswordResetsController < ApplicationController
  def edit
    @user = User.where(token: params[:id]).first
    if @user
      @token = @user.token
    else
      redirect_to expired_token_path
    end
  end

  def update
    @user = User.where(token: params[:id]).first
    if @user.nil?
      redirect_to expired_token_path
    elsif @user.update_attributes(person_params)
      @user.generate_token
      @user.save
      flash[:success] = "Your password has been changed. Please sign in."
      redirect_to sign_in_path
    else
      @token = @user.token
      render :edit
    end
  end

  private

  def person_params
    params.require(:user).permit(:password, :token)
  end
end
