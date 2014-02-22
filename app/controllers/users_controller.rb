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
    if @user.save
      Stripe.api_key = ENV['STRIPE_SECRET_KEY']
      token = params[:stripeToken]
      begin
        charge = Stripe::Charge.create(
          :amount => 999,
          :currency => "usd",
          :card => token,
          :description => "Sign-up charge for #{@user.email}"
        )
        flash[:success] = "Thanks for becoming a member of MyFLix!"
        redirect_to root_path
      rescue Stripe::CardError => e
        flash.now[:error] = e.message
        render :new
      end
      handle_friendship
      @friend_full_name = @friend.user.full_name if @friend
      AppMailer.delay.send_welcome_email(@user, @friend_full_name)
      session[:user_id] = @user.id
      @friend.update_column(:token, nil) if @friend
    else
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

  def handle_friendship
    @friend = Friend.where(token: params[:token]).first if params[:token]
    if @friend
      @user.leaders << @friend.user if @user.allow_to_follow?(@friend.user)
      @friend.user.leaders << @user if @friend.user.allow_to_follow?(@user)
    end
  end
end