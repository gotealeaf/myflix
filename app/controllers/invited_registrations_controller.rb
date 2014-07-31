class InvitedRegistrationsController < ApplicationController

  def new
    @user = User.new
    @friend_name = params[:friend_name]
    @friend_email = params[:friend_email]
    @token = params[:token]
    render 'users/new'
  end
end
