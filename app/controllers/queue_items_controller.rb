class QueueItemsController < ApplicationController
	before_action :require_user
	def index
		@queue_items = QueueItem.where("user_id = #{session[:user_id]}").order("position ASC")
	end

	def create
		queueposition = QueueItem.where(user_id: session[:user_id]).count + 1
		QueueItem.create(user_id: session[:user_id], video_id: params[:video_id], position: queueposition) unless !QueueItem.find_by(user_id: session[:user_id], video_id: params[:video_id]).blank?
		redirect_to my_queue_path
	end

	def destroy
		queueitem = QueueItem.find_by(id: params[:id])
		queueitem.destroy if current_user.queue_items.include?(queueitem)
		redirect_to my_queue_path
	end
end