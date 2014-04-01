class QueueItemsController < ApplicationController
  before_action :require_signed_in, only: [:index]

def index
  @queue_items = current_user.queue_items
end

end
