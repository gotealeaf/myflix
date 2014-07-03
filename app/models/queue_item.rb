class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  delegate :category, to: :video
  delegate :title, to: :video, prefix: :video

  validates_presence_of :user, :video
  validates :position, numericality: { only_integer: true }

  def rating
    review = Review.where(user:user, video:video).first
    return review.nil? ? nil : review.rating
  end

  def category_name
    return category.name
  end

end
