class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :video_id, presence: true
  validates :user_id, presence: true
end