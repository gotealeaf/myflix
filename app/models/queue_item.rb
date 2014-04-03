class QueueItem < ActiveRecord::Base
  belongs_to :video
  belongs_to :user

  delegate :title,      to: :video, prefix: :video
  delegate :categories, to: :video, prefix: :video

  validates_uniqueness_of :position, scope: [ :user_id ]
  validates_uniqueness_of :user_id,  scope: [ :video_id ]
  validates :user_id,  presence: true
  validates :video_id, presence: true
  validates :position, presence: true,
                       numericality: { only_integer: true },
                       uniqueness: true

  def user_rating
    review = Review.where(user_id: user.id, video_id: video.id).first
    review.rating if review
  end

  def video_category_names
    names_array = video_categories.each(&:name)
    names_array if names_array.any?
  end

  def arrange_queue_position!
    # user_queue = QueueItem.where(user_id: user.id).all
    # id_position_array = []
    # user_queue.each.map { |item| id_queue_array << [item.id, item.position] }
    # id_position
  end
end
