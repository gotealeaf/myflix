class QueueItemsController < ApplicationController
  def index
    require_user and return

    @user = User.find(session[:user_id])
    @queue_items = @user.queue_items
    render 'users/my_queue'
  end
end