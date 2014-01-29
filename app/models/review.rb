class Review < ActiveRecord::Base
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'
  belongs_to :video

  validates_presence_of :creator, :rating, :body, :video

  def self.find_rating_by_creator_and_video(user, video)
    if !user.nil? && !video.nil?
      review = self.where(user_id: user, video: video).first

      if !review.nil?
        review.rating
      else
        nil
      end
    end
  end
end
