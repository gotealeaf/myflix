class QueueItemsController < ApplicationController
  before_filter :authorize
  
  def index
    @queue_items = current_user.queue_items
  end
end