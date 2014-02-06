class UsersController < ApplicationController
    before_action :require_user, only: [:show ]

  def new
    @user = User.new
  end

  def new_with_invitation_token

    invitation = Invitation.where(token: (params[:token])).first
    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to failed_token_path
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      AppMailerWorker.perform_async(@user.id)
      # other options
      # AppMailer.delay.welcome_email(@user.id)
      # AppMailer.welcome_email(@user.id).deliver
      handle_invitation
      sign_in_new_user
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def handle_invitation
    if params[:invitation_token].present?
      invitation = Invitation.where(token: params[:invitation_token]).first
      invitation.inviter.follow(@user)
      @user.follow(invitation.inviter)
      invitation.update_columns(token: nil)
    end
  end

  def user_params
    params.require(:user).permit(:email, :full_name, :password)
  end

  def sign_in_new_user
    session[:user_id] = @user.id
    redirect_to home_path
  end

end
