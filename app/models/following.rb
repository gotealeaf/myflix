class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :followee, class_name: 'User'

  delegate :full_name, to: :followee
  delegate :email, to: :followee

  def count_queue_videos
    followee.queue_videos.count
  end

  def count_followers
    Following.where(followee_id: followee.id).count
  end
end
