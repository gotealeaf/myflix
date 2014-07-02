class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_presence_of :rating, :review, :user_id, :video_id
end
