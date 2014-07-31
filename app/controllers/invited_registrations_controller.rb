class InvitedRegistrationsController < ApplicationController
  before_action :require_user 

  def new
    @user = User.new
    @friend_name = params[:friend_name]
    @friend_email = params[:friend_email]
    @inviter = User.find(params[:inviter_id])
    @token = generate_token(@inviter)
    render 'users/new'
  end

  private

  def generate_token(user)
    UserToken.create(token: SecureRandom.urlsafe_base64, user: user)
  end
end
