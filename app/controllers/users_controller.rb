class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      charge = StripeWrapper::Charge.create(
        :amount => 999,
        :card => params[:stripeToken],
        :description => "Sign Up Charge for #{@user.email}"
      )
      if charge.successful?
        @user.save
        handle_invitation
        AppMailer.delay.send_welcome_email(@user)
        redirect_to sign_in_path
      else
        flash[:danger] = charge.error_message
        render :new
      end
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new_with_invitation_token
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  private

  def user_params
    params.require(:user).permit!
  end

  private

  def handle_invitation
    if params[:invitation_token].present?
      invitation = Invitation.where(token: params[:invitation_token]).first
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end

end