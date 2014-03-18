class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_presence_of :rating, :user_id, :video_id

  def update_review_attributes(queue_item)
    update_attributes!(rating: "#{queue_item[:rating]}")
  end

  def self.review_by_user_on_video(user, video)
    where(user: user, video: video).first
  end

  def self.create_new_from_queue(final_queue_item, current_user, queue_item)
    create(video: final_queue_item.video, user: current_user, rating: queue_item[:rating])
  end
end
