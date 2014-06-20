class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  # rails methods instead of writing methods commented out below
  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

=begin
  def video_title
    video.title
  end
=end

  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

  def category_name
    category.name
  end

=begin
  def category
    video.category
  end
=end
end
