class UsersController < ApplicationController
  before_filter :require_user, only: [:show]

  def new
    @user = User.new
  end

  def new_with_token
    friend = Friend.where(token: params[:token]).first
    if friend
      @user = User.new(email: friend.email, full_name: friend.full_name)
      @token = friend.token
      render :new
    else
      redirect_to expired_token_path
    end
  end

  def create
    @user = User.new(user_params)
    sign_up = UserSignUp.new(@user, params[:stripeToken], params[:token]).user_sign_up
    if sign_up.successful?
      session[:user_id] = sign_up.user.id
      flash[:success] = "Thanks for becoming a member of MyFLix!"
      redirect_to root_path
    else
      flash[:error] = sign_up.error_message
      render :new
    end
  end

  def show
    @user = User.find_by_token(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :full_name)
  end
end