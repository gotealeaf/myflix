class QueueItem < ActiveRecord::Base

  belongs_to :user
  belongs_to :video

  validates_presence_of :position, :video_id, :user_id

end
