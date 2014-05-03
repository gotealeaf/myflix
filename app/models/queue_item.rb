class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  
  def video_title
    video.title
  end
  
  def category_names
    #if video.categories > 1
    video.categories 
      
      #.each do |category|
        #category.name
        #end
    #else
      #video.categories.name
    #end
  end
  
  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first #note temporary
    review.rating if review
  end
  
end