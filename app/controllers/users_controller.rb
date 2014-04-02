class UsersController < ApplicationController
  before_action :require_user, only: [:show]
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    begin
      if @user.save
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        token = params[:stripeToken]
        Stripe::Charge.create(
          :amount => 999, # amount in cents, again
          :currency => "usd",
          :card => token,
          :description => "Sign Up Charge for #{@user.email}"
        )
        handle_invitation
        AppMailer.send_welcome_email(@user).deliver
        flash[:info] = 'You are registered.'
        redirect_to login_path
      else
        render :new
      end
    rescue Stripe::CardError => e
      flash.now[:danger] = e.message
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def new_with_invitation_token
    invitation = Invitation.find_by(token: params[:token])
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
    params.require(:user).permit(:email, :password, :fullname)
  end

  def handle_invitation
    if params[:invitation_token].present?
      invitation = Invitation.find_by(token: params[:invitation_token])
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.update_column(:token, nil)
    end
  end
end
