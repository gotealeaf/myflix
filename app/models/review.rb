class Review < ActiveRecord::Base
  belongs_to :creator, foreign_key: :user_id, class_name: :User
  belongs_to :video
  has_many :video_ratings

  validates_presence_of :content, :rating
end