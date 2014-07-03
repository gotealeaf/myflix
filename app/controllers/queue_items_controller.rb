class QueueItemsController < ApplicationController
  before_filter :authorize

  def index
    @queue_items = current_user.queue_items
  end

  def create
    @video = Video.find(params[:video_id])
    if current_user_queue_video?(@video)
      flash[:info] = "#{@video.title} was already in your queue."
    else
      if queue_video(@video)
        flash[:success] = "#{@video.title} was added to your queue"
      else
        flash[:danger] = "There was an error adding #{@video.title} to your queue."
      end
    end
    redirect_to my_queue_path
  end

  def destroy
    queue_item = QueueItem.find(params[:id])
    video_title = queue_item.video.title
    if current_user.queue_items.include?(queue_item)
      queue_item.destroy
      current_user.normalize_queue_positions()
      flash[:success] = "#{video_title} was removed from your queue"
    end
    redirect_to my_queue_path
  end
  
  def update
    begin
      update_queue_items
      current_user.normalize_queue_positions
      flash[:success] = "Your Queue Items have been updated."
    rescue
      flash[:danger] = "Invalid positions for queue items."
    end
    # @qitems = set_positions(params[:items])
    # if save_item_positions(@qitems)
    #   flash[:success] = "Your Queue Items have been updated."
    # else
    #   flash[:danger] = "Invalid positions for queue items."
    # end
    redirect_to my_queue_path
  end

  private

  def queue_video(video)
    QueueItem.create(video:@video,user:current_user, position: new_queue_item_position)
  end

  def new_queue_item_position
    current_user.queue_items.count + 1
  end

  def current_user_queue_video?(video)
    current_user.queue_items.map(&:video).include?(@video)
  end
  
  # def set_positions(form_item_array)
  #   objects = []
  #   form_item_array.each do |i|
  #     qi = QueueItem.find(i['id'])
  #     qi.position = i['position']
  #     objects.push(qi)
  #   end
  #   return objects
  # end
  #
  # def save_item_positions(object_array)
  #   successful = true
  #   begin
  #     ActiveRecord::Base.transaction do
  #       object_array.each do |item|
  #         item.save! if item.user == current_user
  #       end
  #     end
  #     normalize_item_positions()
  #   rescue ActiveRecord::RecordInvalid
  #     successful = false
  #   end
  #   return successful
  # end
  
  def update_queue_items
    ActiveRecord::Base.transaction do
      params[:items].each do |qi_data|
        qi = QueueItem.find(qi_data['id'])
        qi.update_attributes!(position: qi_data['position']) if qi.user == current_user
      end
    end
  end
  
  # def normalize_item_positions
  #   current_user.queue_items.each_with_index do |item,index|
  #     item.update_attribute(:position, index + 1)
  #   end
  # end
  
end
