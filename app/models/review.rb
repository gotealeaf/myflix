class Review < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  validates :rating, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 5  }
  validates_presence_of :video, :user
  validates_presence_of :content

  default_scope { order("created_at DESC") }

  # class methods
  def self.average_rating_for_video(video)
    result = self.where(video:video).average(:rating)
    return result ? result.round(1) : 0
  end
end
