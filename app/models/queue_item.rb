class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_presence_of :user, :video
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

  def self.find_by_user_and_video(user, video)
    self.where(user_id: user, video_id: video).first
  end

  def self.next_available_position(given_user)
    (self.where(user: given_user).maximum(:position) || 0) + 1 if given_user.is_a?(User)
  end
end
