class QueueItem < ActiveRecord::Base

  belongs_to :user
  belongs_to :video

  validates_presence_of :position, :video_id, :user_id
  validates_numericality_of :position, { only_integer: true }

  def self.get_queue_items_for_video_and_user(video_id_provided, user_id_provided)
    where(video_id: video_id_provided, user_id: user_id_provided)
  end
end
