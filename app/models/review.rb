class Review < ActiveRecord::Base
  validates :content, presence: true
  validates :rating, presence: true
  validates :user, presence: true
  validates :video, presence: true

  delegate :title, to: :video, prefix: :video

  belongs_to :video
  belongs_to :user
end