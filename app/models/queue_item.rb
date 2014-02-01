class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_presence_of :ranking
  validates_numericality_of :ranking, {only_integer: true}

  delegate :category, to: :video
  delegate :title, to: :video, prefix: true

  def rating
    review ? review.rating : 0
  end

  def rating=(new_rating)
    my_review = review || Review.new(video: video, user: user)
    my_review.rating = new_rating.to_i == 0 ? nil : new_rating.to_i
    my_review.save(validate: false)
    my_review.destroy if my_review.rating.nil? && my_review.body.to_s.empty?
  end

  def category_name
    category.name if category
  end

  def review
    @review ||= video.reviews.find_by_user_id(user_id)
  end
end