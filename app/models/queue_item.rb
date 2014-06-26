class QueueItem < ActiveRecord::Base
  validates_numericality_of :position, { only_integer: true }

  belongs_to :user
  belongs_to :video

  # when you call .category, "delegate" will just tell rails to call .category on the video model instead of the QueueItem model
  delegate :category, to: :video
  #prefix makes the method name ".video_title" instead of ".title"
  delegate :title, to: :video, prefix: :video 

  def rating
    review.rating if review
  end

  def rating=(new_rating)
    if review
      review.update_column(:rating, new_rating) #using .update_column will bypass validations (reviews typically need content)
    else
      review = Review.create(user: user, video: video, rating: new_rating)
      review.save(validate: false) #again we need to skip validations for the content
    end
  end

  def category_name
    category.name
  end

  private

  def review
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end
end