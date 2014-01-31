class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_presence_of :ranking
  validates_numericality_of :ranking, {only_integer: true}

  delegate :category, to: :video
  delegate :title, to: :video, prefix: true

  def rating
    review = self.video.reviews.find_by_user_id(self.user_id)
    review ? review.rating : 0
  end

  def rating=(new_rating)
    review = video.reviews.find_by_user_id(user_id)
    review = Review.new(video: video, user: user) unless review
    review.rating = new_rating.to_i == 0 ? nil : new_rating.to_i
    review.save(validate: false)
  end

  def category_name
    category.name if category
  end
end