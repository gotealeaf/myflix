class UsersController < ApplicationController
  before_action :require_user, only: [:show ]

  def new
    @user = User.new
  end

  def new_with_invitation_token
    @invitation = Invitation.find(token: params[:token])
    
  end

  def create
    @user = User.new(user_params)
    if @user.save
      AppMailer.welcome_email(@user).deliver
      redirect_to sign_in_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end


  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password)
  end
end
