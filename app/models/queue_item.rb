class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  
  validates_numericality_of :list_order, {only_integer: true}
  
  def video_title
    video.title
  end
  
  def category_names
    video.categories 
  end
  
  def rating
    review.rating if review
  end
  
  def rating=(new_rating) #pushing up the new rating from the my queue page
    if review
      review.update_column(:rating, new_rating)
    else
      review = Review.new(user: user, video: video, rating: new_rating) #'new' and not 'create' is used because create requires presence of both content and ratings under models validations
      review.save(validate: false) #this will bypass validations of the review model which requires both content and rating to be present
      # note the bracket for validate must come immediately after 'save'. No spaces.
    end
  end
  
  private
  
  def review
    @review ||=Review.where(user_id: user.id, video_id: video.id).first
  end
  
end