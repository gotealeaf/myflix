class User < ActiveRecord::Base
  validates_presence_of :email, :password, :full_name
  validates_uniqueness_of :email
  has_secure_password validations: false
  has_many :reviews, -> { order "created_at DESC"}
  has_many :queue_items, -> { order "position asc" }

  def normalize_queue_item_positions
    queue_items.each_with_index do |item, index|
      item.update_attributes(position: index + 1)
    end
  end

  def queued_video?(video)
    queue_items.map(&:video).include?(video)
  end

  def video_queue_count
    queue_items.count
  end
end