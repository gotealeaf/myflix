class Review < ActiveRecord::Base
  validates_presence_of :user_id, :video_id, :rating, :comment

  belongs_to :user
  belongs_to :video
end
