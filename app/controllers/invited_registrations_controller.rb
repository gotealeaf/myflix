class InvitedRegistrationsController < ApplicationController

  def new
    @user = User.new
    @friend_name = params[:friend_name]
    @friend_email = params[:friend_email]
    @inviter_id = params[:inviter_id]
    render 'users/new'
  end
end
