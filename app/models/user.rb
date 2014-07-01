class User < ActiveRecord::Base
  has_many :queue_items, -> { order :position }
  has_many :reviews, -> { order "created_at DESC" }
  has_many :following_relationships, class_name: "Relationship", foreign_key: :follower_id
  has_many :leading_relationships, class_name: "Relationship", foreign_key: :leader_id

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

  def following?(leader, follower)
    Relationship.exists?(leader_id: leader.id, follower_id: follower.id)
  end

end
