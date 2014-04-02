class QueueItem < ActiveRecord::Base
  belongs_to :user
  belongs_to :video

  validates :user, presence: true
  validates :video, presence: true
  validates :position, uniqueness: { scope: :user_id }

  after_initialize :assign_position

  def assign_position
    self.position ||= self.user.queue_items.count + 1 if !!self.user
  end
end