class UsersController < ApplicationController

  def show
    @user = User.find(params[:id])
  end

  def index
  end

  def new
    if current_user
      redirect_to videos_path 
    else
      @user = User.new
    end
  end

  def create
    @user = User.new(user_params)
    if @user.valid?
      charge = StripeWrapper::Charge.create(
        :amount => 999,
        :card => params[:stripeToken],
        :description => "Sign up charge for #{@user.email}"
        )
      if charge.successful?
        @user.save
        handles_invitation
        AppMailer.delay.notify_on_registration(@user.id)
        session[:user_id] = @user.id
        redirect_to videos_path, notice: "Thank you for signing up"
      else
        flash[:error] = charge.error_message
        render :new
      end
    else
      render "new"
    end
  end

  def register_with_token
    if @invitation = Invitation.where(token_params).first
      @user = User.new(email: @invitation.guest_email, token: @invitation.token)
      @invitation_token = @invitation.token
      render 'new'
    else
      redirect_to expired_token_path
    end
  end

private

  def handles_invitation
    if params[:token].present?
      invitation = Invitation.where(token: params[:token]).first
      @user.follow!(invitation.inviter)
      invitation.inviter.follow!(@user)
      invitation.update_columns(token: nil)
    end
  end

  def token_params
    params.permit(:token)
    
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :token)
  end
end