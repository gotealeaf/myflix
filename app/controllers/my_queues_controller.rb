class MyQueuesController < ApplicationController 
  before_filter :require_user

  def index
    @my_queue = current_user.my_queues

  end
end