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
    result = UserSignup.new(@user).sign_up(params[:stripeToken], params[:invitation_token])
    if result.successful?
      session[:user_id] = @user.id
      flash[:success] = "Thank you for signing up"
      redirect_to videos_path
    else
      flash[:error] = result.error_message
      render :new
    end
  end

  def register_with_token
    if @invitation = Invitation.where(invitation_token_params).first
      @user = User.new(email: @invitation.guest_email, token: @invitation.invitation_token)
      @invitation_token = @invitation.invitation_token
      render 'new'
    else
      redirect_to expired_token_path
    end
  end

private

  def invitation_token_params
    params.permit(:invitation_token)
    
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :token)
  end
end