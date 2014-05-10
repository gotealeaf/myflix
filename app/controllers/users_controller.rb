class UsersController < ApplicationController
  def new
    if logged_in?
      flash[:warning] = "You are already logged in."
      redirect_to home_path
    end
    
    @user = User.new
  end

  def new_from_invitation
    if logged_in?
      flash[:warning] = "You are already logged in."
      redirect_to home_path
    elsif invitation = Invitation.find_by_token(params[:token])
      @user = User.new(email: invitation.invitee_email, full_name: invitation.invitee_name )
      @invitation_token = invitation.token
      render :new
    else
      flash[:warning] = "The token is expired but you can still register."
      redirect_to register_path
    end
  end

  def create
    @user = User.new(user_params)

    if @user.save
      handle_invitation
      AppMailer.registration_email(@user).deliver
      redirect_to sign_in_path
    else
      render :new
    end
  end

  def show
    require_user
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :full_name, :password, :password_confirmation)
  end

  def handle_invitation
    if invitation = Invitation.find_by_token(params[:invitation_token])
      @user.follow(invitation.inviter)
      invitation.inviter.follow(@user)
      invitation.destroy
    end
  end
end