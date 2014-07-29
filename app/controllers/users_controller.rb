class UsersController < ApplicationController
  before_filter :require_user, only: [:show]
    
  def new
    @user_token = params[:token]
    @user = User.new
    @user.email = params[:email]
  end

  def create
    @user = User.new(user_params)
    if @user.save
      AppMailer.send_welcome_email(@user).deliver
      create_invitation_relationships @user, params
      
      StripeWrapper::Charge.create(
        :amount      => 999,
        :currency    => "usd",
        :card        => params[:stripeToken],
        :description => "Sign up charge for #{ @user.email }"
      )

      flash[:notice] = "You have succesfully created your account"
      redirect_to sign_in_path
    else
      flash[:error] = "User couldn't be created. #{@user.errors.full_messages.first}"
      render :new
    end
  end

  def show
    @user = User.find_by_token(params[:id])
  end

  def forgot_password
     @user = User.find_by_email(params[:email])
    if @user
      message = AppMailer.send_forgot_password_email(@user).deliver 
      set_reset_password_email_at @user
      redirect_to sign_in_path
    else
      flash[:error] = "There is no user account registered with this email, please type it again or register if you have not done it yet."
    end   
  end

  def reset_password
    user = User.find_by_token(params[:id])
  end

  def update
    user = User.find_by_token(params[:token])
  end

  def new_with_invitation_token  
    invitation = Invitation.find_by_token(params[:token])
    if invitation
      @user = User.new(email: invitation.recipient_email)
      @invitation_token = invitation.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  private

  def create_invitation_relationships user, params
    invitation = Invitation.find_by_token(params[:invitation_token])
    if invitation
      create_relationships invitation.inviter, user 
      invitation.update_column(:token, nil)
    end        
  end

  def user_params
    params.require(:user).permit(:email, :password, :full_name, :password_confirmation)
  end

  def set_reset_password_email_at user
    message = ActionMailer::Base.deliveries.last
    if message
      user.reset_password_email_sent_at = message.date 
      user.save(:validate => false)
    end
  end

  def create_relationships inviter_user, invited_user
    inviter_user.follow invited_user
    invited_user.follow inviter_user
  end
end