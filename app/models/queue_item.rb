class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
   validates_numericality_of :position, :greater_than => 0, :only_integer => :true

  def rating
    reviews = Review.where(user_id: user_id, video_id: video_id)
    reviews.count > 0 ? reviews.first.rating : nil
  end

def rating= new_rating
    review = Review.where(user_id: user_id, video_id: video_id).first
    if review.present?
      #bypass validation
       review.update_column(:rating, new_rating)
    else
       review = Review.create(user_id: user_id, video_id: video_id, rating:new_rating)
       review.save(validate: false)
    end

  end



end
