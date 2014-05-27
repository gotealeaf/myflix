class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  
  
  delegate :category, to: :video  # in lieu of method 'category' which is called from index.html
                                    # as queue_item.category.  The delegation returns video.category 
                                    #we don't have to write a method here
  delegate :title, to: :video, prefix: :video #the prefix is put coz the method call 
                                              #from the index.html is queue_item.video_title (compare with above)
                                              #the delegation returns video.title.  No need to write a method called
                                              #def video_title

  
  def rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

  def category_name
    self.video.category.name
  end

  
end
