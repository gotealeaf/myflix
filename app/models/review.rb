class Review < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates_presence_of :rating, :content, :user_id, :video_id

  def update_review_attributes(queue_item)
    binding.pry
    update_attributes!(rating: "#{queue_item[:position]}")
  end
end
