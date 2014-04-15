class QueuesController < ApplicationController
  before_action :require_user, only: [:create, :destroy, :update_instant]
  def create
    queue_target  = ( QueueItem.where(user: current_user).count + 1  )
    @queue_item = QueueItem.create(
      video: Video.find( params[:video_id] ),
      user: current_user,
      position: queue_target
    ) 
    redirect_to my_queue_path
  end

  def index; end

  def destroy
   @queue_item =  QueueItem.find(params[:id])
   @queue_item.destroy if @queue_item.user == current_user
    redirect_to my_queue_path
  end

  def update_instant
    queue_items_ids = params[:queue_items].map{ |key, value| key.to_i } 
    queue_items_ids.each do |id| 
      queue_item = QueueItem.find(id)
      user = queue_item.user
      video = queue_item.video
      rating = params[:queue_items][id.to_s][:rating]
        if !queue_item.review? && !rating.blank?
          review = Review.create(user: user, video: video, rating: 0)
          queue_item.save
        end
        if queue_item.review? 
          queue_item.save_rating(rating) 
        end
    end

    if validation_of_list_order
      id_sequence_array  = arrange_position
      id_sequence_array.each_with_index do |obj, index| 
        queue_item = QueueItem.find(obj[:id])
        queue_item.position = ( index + 1 )
        queue_item.save
      end
    end
    redirect_to my_queue_path

  end

  private

  def arrange_position
    queue_items_ids = params[:queue_items].map{|key, value| key.to_i } 
    queue_items = queue_items_ids.map do |id|
      { id: id, position: params[:queue_items][id.to_s][:position] }
    end
    queue_items.sort_by! {|obj| obj[:position].to_i }
  end

  def validation_of_list_order
    queue_items_ids = params[:queue_items].map{|key, value| key.to_i } 
    queue_items_positions = queue_items_ids.each.map{ |id| params[:queue_items][id.to_s][:position].to_i }
    counter = 0
    queue_items_positions.each do |position|
      same = 0
      queue_items_positions.each do |check|
        same += 1 if position == check
      end
      counter += 1 if same > 1
    end
    counter == 0 ? true : false
  end


end
