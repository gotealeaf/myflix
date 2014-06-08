class UsersController < ApplicationController
  before_action :find_user, only: [:edit, :update, :show]
  before_action :require_user, except: [:new, :create, :new_with_token]
 
  def new
    @user = User.new
  end
  
  def new_with_token
    invitation = Invitation.where(token: params[:token]).first
    if invitation
      @user = User.new(email: invitation.recipient_email) #prefill the email field 
      @invitation_token = invitation.token
      render :new
    else
      redirect_to invalid_token_path
    end
  end
  
  def create
    @user = User.new(user_params)
      if @user.valid?
        token = params[:stripeToken]
        Stripe.api_key = ENV['STRIPE_SECRET_KEY']
        charge = StripeWrapper::Charge.create(
          :amount => 999, 
          :card => token, 
          :description => "Sign up charge for #{@user.email}"
        )
        #if user input is valid, check if the charge is successful
        if charge.successful?
          @user.save
          handle_invitation
          AppMailer.delay.send_welcome_email(@user)
          session[:user_id] = @user.id
          flash[:success] = "Welcome to MyFlix, #{@user.full_name}. You have successfully paid GBP 9.99 for a one month membership."
          #flash[:success] = "You are now logged in."
          redirect_to videos_path
        else
          flash[:danger] = charge.error_message
          render :new
        end
      else
        flash[:danger] = "Your account could not be created."
        render :new
      end
  end
    
  def show
  end
  
  def edit
  end
  
  def update
    if @user.update
      flash[:info] = "Your profile was updated."
      redirect_to user_path(@user)
    else
      flash[:warning] = "Your profile could not be updated."
    end
  end
    
  private
  
  def find_user
    @user = User.find(params[:id])
  end
  
  def handle_invitation
    if params[:invitation_token].present? 
      invitation = Invitation.where(token: params[:invitation_token]).first
      @user.follow(invitation.inviter) #where user invited to join by existing user and automatically follows existing user
      invitation.inviter.follow(@user) #where existing user follows the person invited
      invitation.update_column(:token, nil) #expires the token upon acceptance
    end
  end
  
  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end

end