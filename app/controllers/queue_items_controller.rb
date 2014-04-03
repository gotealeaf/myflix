class QueueItemsController < ApplicationController
  before_action :require_signed_in
  before_action :require_owner,     only: [:destroy]


  def index
    @queue_items = current_user.queue_items
  end

  def create
    renumber_positions
    @video      = Video.find(params[:video_id])
    @queue_item = QueueItem.create(video_id: params[:video_id],
                                   user: current_user,
                                   position: next_position)
    if @queue_item.valid?
      flash[:notice] = "Video added to your queue."
      redirect_to my_queue_path
    else
      flash[:error] = "Video is already in your queue."
      redirect_to video_path(@video)
    end
  end

  def update_queue
    begin
      attempt_to_update_database
      renumber_positions
      flash[:notice] = "Queue order updated."
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid queue numbering. Only integer numbers(1,2,3...99,100...), and no duplicate numbers allowed."
    end
    redirect_to my_queue_path
  end

  def destroy
    QueueItem.find(params[:id]).destroy
    redirect_to my_queue_path
    renumber_positions
  end

  private

    def attempt_to_update_database
      ActiveRecord::Base.transaction do
        params[:queue_items].each do |queue_item|
          QueueItem.find(queue_item["id"]).update_attributes!(position: queue_item["position"])
        end
      end
    end

    def renumber_positions
      current_user.queue_items.each_with_index do |item, index|
        QueueItem.find(item.id).update_attributes(position: (index+1) )
      end
    end

    # def arrange_by_relative_position
    #   order_array = current_user.queue_items.map{|e| [e.id, e.position]}
    #   order_array.sort_by!{|e| e[1]}
    # end

    def next_position
      (current_user.queue_items.count + 1)
      # last_position = arrange_by_relative_position.last[1]
      # last_position += 1
    end

    def require_owner
      redirect_to root_path unless (queue_owner == current_user)
    end

    def queue_owner
      QueueItem.find(params[:id]).user
    end
end
