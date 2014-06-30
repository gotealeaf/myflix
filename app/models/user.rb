class User < ActiveRecord::Base
  has_many :queue_items, -> { order :position }
  has_secure_password validations: false
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, on: :create, length: {minimum: 5}
  validates :full_name, presence: true

  def normalize_queue_item_positions
    queue_items.each_with_index do |queue_item, index|
      queue_item.update_attributes(position: index + 1)
    end
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  # passes tests, but didn't work on UI because not looking up in specific user's queue_items
  # QueueItem.exists?(video)
  end

end
