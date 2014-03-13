class Review < ActiveRecord::Base
  belongs_to :creator, class_name: "User", foreign_key: "user_id"
  belongs_to :video

  validates :rating, presence: true
  validates :review_text, presence: true, length: { minimum: 50 }
  validates :user_id, presence: true
  validates :video_id, presence: true
  validates_uniqueness_of :user_id, scope: :video_id, message: "you can only review a video once."
end