class QueueItem < ActiveRecord::Base

  belongs_to :user
  belongs_to :video

  validates_presence_of :position, :video_id, :user_id
  validates_numericality_of :position, { only_integer: true }

  def self.get_queue_items_for_video_and_user(video_id_provided, user_id_provided)
    where(video_id: video_id_provided, user_id: user_id_provided)
  end

  def update_position
    binding.pry
    final_item = QueueItem.find(queue_item[:id])
    final_item.update_attributes!("position"=>"#{queue_item[:position]}") if final_item.user == current_user
    if queue_items_are_owned_by_user(queue_items) != true
      raise "The user is trying to alter queue items they do not own."
    end
  end
end
