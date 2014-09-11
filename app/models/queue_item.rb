class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
   validates_numericality_of :position, :greater_than => 0, :only_integer => :true

  def rating
    review.present? ? review.rating : nil
  end

def rating= new_rating
    
    if review.present?
      #bypass validation
       review.update_column(:rating, new_rating)
    else
       new_review = Review.new(user_id: user_id, video_id: video_id, rating:new_rating)
       new_review.save(validate: false)
    end

  end

  def review
    #instance variable to prevent going to db again
    @review ||= Review.where(user_id: user_id, video_id: video_id).first
  end


end
