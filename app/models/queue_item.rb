class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  # rails delegate methods instead of writing method examples commented out below
  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates :position, numericality: { only_integer: true }

=begin
  def video_title
    video.title
  end
=end

  def rating
    @review.rating if review
  end

  def rating=(new_rating)
    if review
      # update column here instead of update_attributes, bypasses validation of content
      @review.update_column(:rating, new_rating)
    else
      # have to do new / save to bypass validation of content, Review.create is nil otherwise
      review = Review.new(user: user, video: video, rating: new_rating)
      review.save(validate: false)
    end
  end

  def category_name
    category.name
  end

=begin
  def category
    video.category
  end
=end

  private

  def review
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end

end
