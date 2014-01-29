class User < ActiveRecord::Base
  has_many :reviews, -> { order(created_at: :desc) }
  has_many :queue_items

  validates :email, presence: true, uniqueness: true
  validates_presence_of :full_name

  has_secure_password validations: false
  validates_presence_of :password

  def next_available_position
    (self.queue_items.maximum(:position) || 0) + 1
  end

  def queued_videos
    queue_items.map(&:video)
  end
end
