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
    if params[:token].present?
      guest_user_signs_in_follows_inviter_and_inviter_follows_guest
      AppMailer.delay.notify_on_registration(@user.id)
      session[:user_id] = @user.id
      redirect_to videos_path, notice: "Thank you for signing up"
    elsif @user.save
      AppMailer.notify_on_registration(@user.id)
      session[:user_id] = @user.id
      redirect_to videos_path, notice: "Thank you for signing up"
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

  def guest_user_signs_in_follows_inviter_and_inviter_follows_guest
    @user = User.new(user_params.merge!(token_params))
    invitation = Invitation.where(token: @user.token).first
    inviter = User.find_by(id: invitation.inviter_id)
    invitation.update_columns(token: SecureRandom.urlsafe_base64)
    @user.save
    @user.follow!(inviter)
    inviter.follow!(@user)
  end

  def token_params
    params.permit(:token)
    
  end

  def user_params
    params.require(:user).permit(:full_name, :email, :password, :token)
  end
end