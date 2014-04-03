class QueueItemsController < ApplicationController
  before_action :require_signed_in
  before_action :require_owner,     only: [:destroy]


  def index
    @queue_items = current_user.queue_items
  end

  def create
    current_user.renumber_positions
    @video      = Video.find(params[:video_id])
    @queue_item = QueueItem.create(video_id: params[:video_id],
                                   user: current_user,
                                   position: current_user.next_position)
    if @queue_item.valid?
      flash[:notice] = "Video added to your queue."
      redirect_to my_queue_path
    else
      flash[:error] = "Video is already in your queue."
      redirect_to video_path(@video)
    end
  end

  def update_queue
    #binding.pry
    begin
      attempt_to_update_database
      current_user.renumber_positions
      flash[:notice] = "Queue order updated."
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid queue numbering. Only integer numbers(1,2,3...99,100...), and no duplicate numbers allowed."
    end
    redirect_to my_queue_path
  end

  def destroy
    QueueItem.find(params[:id]).destroy
    redirect_to my_queue_path
    current_user.renumber_positions
  end

  private

    def attempt_to_update_database
      ActiveRecord::Base.transaction do
        params[:queue_items].each do |queue_item|
          QueueItem.find(queue_item["id"]).update_attributes!(position: queue_item["position"])
        end
      end
    end

    def require_owner
      redirect_to root_path unless (queue_owner == current_user)
    end

    def queue_owner
      QueueItem.find(params[:id]).user
    end
end
