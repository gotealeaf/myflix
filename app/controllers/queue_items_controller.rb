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
    after_create_check_flash_and_redirect
  end

  def update_queue
    update_queue_items
    redirect_to my_queue_path
  end

  def destroy
    QueueItem.find(params[:id]).destroy
    redirect_to my_queue_path
    current_user.renumber_positions
  end

  ############################## PRIVATE METHODS ###############################
  private

    def after_create_check_flash_and_redirect
      if @queue_item.valid?
        flash[:notice] = "Video added to your queue."
        redirect_to my_queue_path
      else
        flash[:error] = "Video is already in your queue."
        redirect_to video_path(@video)
      end
    end

    def update_queue_items
      begin
        transaction_to_update_database
        current_user.renumber_positions
        flash[:notice] = "Queue order updated."
      rescue ActiveRecord::RecordInvalid
        flash[:error] = "Invalid queue numbering. Only integer numbers(1,2,3...99,100...). No duplicate numbers."
      end
    end

    def transaction_to_update_database
      ActiveRecord::Base.transaction do
        set_positions_initially_to_nil
        attempt_to_update_positions_per_user_entries
      end
    end

    def set_positions_initially_to_nil
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data["id"])
        queue_item.update_attributes!(position: nil)
      end
    end

    def attempt_to_update_positions_per_user_entries
      params[:queue_items].each do |queue_item_data|
        queue_item = QueueItem.find(queue_item_data["id"])
        queue_item_data["position"] = "blank" if queue_item_data["position"].blank?
        queue_item.update_attributes!(position: queue_item_data["position"],
                                      rating: queue_item_data["rating"]) if queue_item.user == current_user
      end
    end

    def require_owner
      redirect_to root_path unless (queue_owner == current_user)
    end

    def queue_owner
      QueueItem.find(params[:id]).user
    end
end
