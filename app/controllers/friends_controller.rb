class FriendsController < ApplicationController
  before_filter :require_user
  
  def new
    @friend = Friend.new
  end

  def create
    email = params[:email]
    @friend = Friend.new(friend_param)
    @friend.user_id = current_user.id
    if @friend.email != current_user.email && @friend.save
      AppMailer.send_friend_email(email, @friend, link_for_reset(@friend.token)).deliver
      flash[:success] = "#{@friend.full_name} has been invited to be your friend!"
      redirect_to new_friend_path
    else
      flash[:error] = @friend.valid? ? "You can't invite yourself to be a member." : "Please fix the errors below:"
      render :new
    end
  end

  private

  def friend_param
    params.require(:friend).permit(:full_name, :email, :message)
  end

  def link_for_reset(token)
    if request.host == 'localhost'
      request.protocol + request.host_with_port + '/register/' + token
    else
      request.protocol + request.host + '/register/' + token
    end
  end
end