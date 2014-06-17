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
    result = UserSignUp.new(@user).sign_up(params[:stripeToken], params[:invitation_token])
    if result.successful?
      session[:user_id] = @user.id
      flash[:success] = "Welcome to MyFlix, #{@user.full_name}. You have successfully paid GBP 9.99 for a one month membership."
      redirect_to videos_path
    else
      flash[:error] = result.error_message
      render :new
    end
  end
    
  def show
  end
  
  def edit
    if @user.update
      flash[:success] = "Your profile has been updated."
      redirect_to home_path
    else
      flash[:danger] = "Your profile could not be updated."
      render :edit
    end
  end
  
  def update
    if @user.update(user_params)
      flash[:info] = "Your profile was updated."
      redirect_to user_path(@user)
    else
      flash[:warning] = "Your profile could not be updated."
      render :edit
    end
  end
  
  def account
    
  end
    
  private
  
  def find_user
    @user = User.find(params[:id])
  end
  
  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end

end