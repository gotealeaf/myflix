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
    if invitation = Invitation.where(guest_email: @user.email).first
      other_user = User.where(email: invitation.inviter_email).first
      @user.save
      @user.follow!(other_user)
      other_user.follow!(@user)
      AppMailer.notify_on_registration(@user).deliver
      session[:user_id] = @user.id
      redirect_to videos_path, notice: "Thank you for signing up"
    elsif @user.save
      AppMailer.notify_on_registration(@user).deliver
      session[:user_id] = @user.id
      redirect_to videos_path, notice: "Thank you for signing up"
    else
      render "new"
    end
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :email, :password)
  end
end