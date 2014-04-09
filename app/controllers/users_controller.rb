class UsersController < ApplicationController
  before_action :require_signed_in,   only: [:show]
  before_action :set_user,            only: [:show]
  before_action :require_valid_invitation_token, only: [:new_with_token]

  def new
    @user = User.new
  end

  def new_with_token
    @invitation = Invitation.find_by(token: params[:token])
    @token = @invitation.token
    @user = User.new(email: @invitation.friend_email)
    render 'new'
  end

  def create
    @token = params[:token]
    @user = User.new(user_params)
    if @user.save
      users_by_invitation_are_cofollowers
      MyflixMailer.welcome_email(@user).deliver
      flash[:notice] = "Welcome to myFlix!"
      signin_user(@user)
    else
      render 'new'
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :password, :token)
    end

    def require_valid_invitation_token
      redirect_to expired_token_path unless Invitation.find_by(token: params[:token])
    end

    def set_user
      @user = User.find(params[:id])
    end

    def require_owner
      User.find(params[:id]) == current_user if signed_in?
    end

    def users_by_invitation_are_cofollowers
      if !@token.blank?
        @invitation = Invitation.find_by(token: @token)
        @inviter = User.find_by(id: @invitation.inviter_id)
        @inviter.follow(@user)
        @user.follow(@inviter)
        @invitation.clear_invitation_token
      end
    end
end
