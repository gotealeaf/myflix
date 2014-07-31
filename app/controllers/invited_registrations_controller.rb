class InvitedRegistrationsController < ApplicationController

  def new
    case !!UserToken.find_by(token: params[:token])
    when true
      @user = User.new
      @friend_name = params[:friend_name]
      @friend_email = params[:friend_email]
      @token = params[:token]
      render 'users/new'
    when false then redirect_to register_path
    end
  end
end
