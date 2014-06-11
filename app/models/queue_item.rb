class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video
  validates_numericality_of :position, {only_integer: true}
  
  delegate :category, to: :video  # in lieu of method 'category' which is called from index.html
                                    # as queue_item.category.  The delegation returns video.category 
                                    #we don't have to write a method here
  delegate :title, to: :video, prefix: :video #the prefix is put coz the method call 
                                              #from the index.html is queue_item.video_title (compare with above)
                                              #the delegation returns video.title.  No need to write a method called
                                              #def video_title

  
  def rating
    
    review.rating if review
  end

  def category_name
    self.video.category.name
  end

#the following is a setter method for the VIRTUAL ATTRIBUTE 'rating' of the class QueueItem.  Since
#rating is not part of the QueueItem model, the getter and setter methods
 #are being explicitly created here.  Unlike, "position" which is an attribute
#of the model QueueItem and is present in the schema table. In this case the
#accessor methods are implicitly created by rails

  def rating=(new_rating)  
    
    if review 
      
       review.update_column(:rating, new_rating)
      
    else
      review = Review.new(user_id: user.id, video_id: video.id, rating: new_rating)
      review.save(validate: false)
    end
  end

  
  
  private

  def review
    @review ||= Review.where(user_id: user.id, video_id: video.id).first
  end

end
