# params data structure
#{"queue_item.id" =>{position: "", rating: ""}}


class QueuesController < ApplicationController

  before_action :require_user, only: [:create, :destroy, :update_instant]

  def create
    queue_target  = ( QueueItem.where(user: current_user).count + 1  )
    @queue_item = QueueItem.create(
      video: Video.find( params[:id] ),
      user: current_user,
      position: queue_target
    ) 
    redirect_to my_queue_path
  end

  def index; end

  def destroy
   @queue_item =  QueueItem.find(params[:id])
   @queue_item.destroy if @queue_item.user == current_user
   arrange_position_after_destroy
    redirect_to my_queue_path
  end

  def update_instant
    assign_ratings
    arrange_and_save_position if validation_of_list_order
    redirect_to my_queue_path
  end

  private

  def assign_ratings
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
  end

  def arrange_position_after_destroy
    queue_item_ids = QueueItem.where(user: current_user).map(&:id)
    queue_items_hash = queue_item_ids.map do |id|
      { id: id, position: QueueItem.find(id).position }
    end
    assign_position_values(queue_item_ids, queue_items_hash)
  end

  def arrange_and_save_position
    queue_item_ids = params[:queue_items].map{|key, value| key.to_i } 
    queue_items_hash = queue_item_ids.map do |id|
      { id: id, position: params[:queue_items][id.to_s][:position] }
    end
    assign_position_values(queue_item_ids, queue_items_hash)
  end

  def assign_position_values(queue_item_ids, queue_items_hash)
    queue_items_hash.sort_by! {|obj| obj[:position].to_i }

    #[ {id , position}, ... ] array sequence is order by position
    queue_items_hash.each_with_index do |obj, index| 
      queue_item = QueueItem.find(obj[:id])
      queue_item.position = ( index + 1 )
      queue_item.save
    end
  end

  def validation_of_list_order
    queue_items_ids = params[:queue_items].map{|key, value| key.to_i } 
    queue_items_positions = queue_items_ids.each.map{ |id| params[:queue_items][id.to_s][:position].to_i }
    counter = 0

    #same user check
    queue_items_ids.each {|id| counter += 1 if QueueItem.find(id).user != current_user}

    #all integer or not check
    queue_items_positions.each {|position| counter += 1 if !position.is_a? Integer}

    #position repetition check
    queue_items_positions.each do |position|
      same = 0
      queue_items_positions.each do |check|
        same += 1 if position == check
      end
      counter += 1 if same > 1
    end

    #return
    counter == 0 ? true : false
  end


end
