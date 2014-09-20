class PasswordResetsController < ApplicationController

  def show
    token = params[:id]
    @user = User.find_by_token(token) unless token.blank?
    if @user.blank?
      redirect_to invalid_token_path
    end
  end

  def create
    token = params[:token]
    @user = User.find_by_token(token) unless token.blank?
    if @user.present?
      @user.password = params[:password]
      @user.generate_token
      if @user.save
        flash[:notice] = 'Password has been reset'
      end  
      redirect_to sign_in_path
    else
      redirect_to invalid_token_path
    end
  end

  def invalid_token
  end

end
