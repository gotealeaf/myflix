class Review < ActiveRecord::Base
  belongs_to :creator, foreign_key: :user_id, class_name: 'User'
  belongs_to :video

  validates_presence_of :creator, :rating, :body, :video
end
