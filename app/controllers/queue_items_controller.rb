class QueueItemsController < ApplicationController
	before_filter :require_user

	def index 
		@queue_items = current_user.queue_items
	end

	def create
		redirect_to my_queue_path
	end

end	