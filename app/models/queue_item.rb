class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_uniqueness_of :video_id, scope: :user_id

  delegate :title, to: :video, prefix: :video
  delegate :category, to: :video, prefix: :video

  def video_rating(user)
    return self.rating unless self.rating.nil?

    if Review.where(creator: user, video: self.video).count > 0
      Review.where(creator: user, video: self.video).order(created_at: :desc).first.rating
    else
      nil
    end
  end
end
