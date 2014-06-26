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

  def update_queue
    begin
      update_queue_items
      normalize_queue_item_positions
    rescue ActiveRecord::RecordInvalid
      flash[:error] = "Invalid Position Numbers"
    end
  end



end
