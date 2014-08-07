class QueueItem < ActiveRecord::Base

  belongs_to :creator, class_name: User, foreign_key: :user_id
  belongs_to :video

  validates :ranking, numericality: { only_integer: true }
  validates_presence_of  :creator, :video

  def video_title
    video.title
  end

  def category
    video.category
  end

  def category_name
    category.name
  end

  def display_rating
    video.display_rating
  end

  def rating
    review.rating if review
  end

  def rating=(new_rating)
    if review
      review.update_columns(rating: new_rating)
    else
      review = video.reviews.new(creator: creator, rating: new_rating)
      review.save(validate: false)
    end
  end

  def review
    @review ||= video.reviews.find_by_user_id(user_id)
  end
end
