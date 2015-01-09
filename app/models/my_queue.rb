  class MyQueue < ActiveRecord::Base
  has_many :videos, -> { order "my_queue_video.index" }, through: :my_queue_videos 
  belongs_to :user
  has_many :my_queue_videos
end