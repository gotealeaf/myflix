class QueueItemsController < ApplicationController
  before_filter :logged_in?

  def index
    @queue_items = current_user.queue_items
  end
end
