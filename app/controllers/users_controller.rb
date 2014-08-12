
class UsersController < ApplicationController

  before_action :require_user, except: [:new, :create]

  def new
    @user = User.new
  end

  def create
    @user = User.create(user_params)
    if @user.save
      charge_customer
      flash[:success] = "Welcome #{@user.full_name}!"
      session[:username] = @user.username
      MyflixMailer.delay.welcome_email(current_user.id)
      follow_inviter_if_invited
      delete_token_if_invited
      redirect_to videos_path
    else
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
  end

  private

  def user_params
    params.require(:user).permit(:full_name, :username, :email, :password, :password_confirmation)
  end

  def follow_inviter_if_invited
    unless params[:token].blank?
      inviter = UserToken.find_by(token: params[:token]).user
      Following.create(user: @user, followee: inviter)
      Following.create(user: inviter, followee: @user)
    end
  end

  def delete_token_if_invited
    unless params[:token].blank?
      user_token = UserToken.find_by(token: params[:token])
      user_token.delete
    end
  end

  def charge_customer
    Stripe.api_key = Rails.env.development? ? Rails.application.secrets.stripe_sec_key : ENV['STRIPE_SECRET_KEY']
    token = params[:stripeToken]
    Stripe::Charge.create(
      :amount => 999,
      :currency => "aud",
      :card => token,
      :description => "Sign up charge for #{ @user.email }"
    )
  end
end
